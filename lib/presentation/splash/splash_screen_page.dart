import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  String _version = '';
  late final AnimationController _animationController;
  Timer? _minimumTimeTimer;
  bool _isReadyToNavigate = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _initPackageInfo();
    _loadTranslations();
    BlocProvider.of<SettingsCubit>(context).loadSettings();

    // Asegurar un tiempo mínimo de visualización
    _minimumTimeTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _isReadyToNavigate = true;
      });
    });
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
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
    if (mounted) {
      setState(() {
        _version = '${info.version}+${info.buildNumber}';
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _minimumTimeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<TranslationErrorCubit, TranslationErrorState>(
      listener: (context, state) {
        if (state is TranslationLoaded && _isReadyToNavigate) {
          _minimumTimeTimer?.cancel();
          GoRouter.of(context).pushNamed(Routes.logIn.name);
        } else if (state is TranslationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: WalletGuruLayout(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        showBackButton: false,
        showBottomNavigationBar: false,
        children: [
          // Animación Lottie
          Container(
            constraints: BoxConstraints(
              maxHeight: size.height * 0.3,
              maxWidth: size.width * 0.7,
            ),
            child: Lottie.asset(
              'assets/splash.json',
              controller: _animationController,
              onLoaded: (composition) {
                _animationController
                  ..duration = composition.duration
                  ..forward();
              },
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 20),

          // Versión
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
