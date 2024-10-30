import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/infrastructure/login/data_sources/login_data_sources.dart';

import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/application/settings/settings_cubit.dart';
import 'package:wallet_guru/application/translations_error/translation_error_state.dart';
import 'package:wallet_guru/application/translations_error/translation_error_cubit.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String _version = '';

  @override
  void initState() {
    _initPackageInfo();
    _loadTranslations();
    _checkTokenExpiration();
    BlocProvider.of<SettingsCubit>(context).loadSettings();
    super.initState();
  }

  void _loadTranslations() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String deviceLanguage = getDeviceLanguage();
      BlocProvider.of<TranslationErrorCubit>(context)
          .loadTranslations(deviceLanguage);
    });
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${info.version}+${info.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TranslationErrorCubit, TranslationErrorState>(
      listener: (context, state) {
        if (state is TranslationLoaded) {
          setInitialRoute(context);
        } else if (state is TranslationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
        }
      },
      child: WalletGuruLayout(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        showBackButton: false,
        showBottomNavigationBar: false,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Image.asset(
              Assets.iconLogoSplash,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Version $_version',
            style: GoogleFonts.montserrat(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

String getDeviceLanguage() {
  final String deviceLocale =
      WidgetsBinding.instance.window.locales.first.languageCode;
  return Intl.canonicalizedLocale(deviceLocale);
}

Future<void> setInitialRoute(BuildContext context) async {
  final storage = await SharedPreferences.getInstance();
  final String? basic = storage.getString('Basic');
  final bool? isWalletCreated = storage.getBool('isWalletCreated');
  if (basic != null && isWalletCreated == false) {
    GoRouter.of(context).pushNamed(Routes.home.name);
  } else {
    GoRouter.of(context).pushNamed(Routes.logIn.name);
  }
}

Future<void> _checkTokenExpiration() async {
  final storage = await SharedPreferences.getInstance();
  final String? basic = storage.getString('Basic');
  if (basic == null) {
    return;
  }
  Map<String, dynamic> payload = Jwt.parseJwt(basic);
  int expirationTimestamp = payload['exp'] as int;

  DateTime expirationDate =
      DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);
  print('Expiration date: $expirationDate');
  bool isExpired = Jwt.isExpired(basic);
  if (isExpired) {
    LoginDataSource().refreshToken();
  } else {
    print('Token is not expired');
    return;
  }
}
