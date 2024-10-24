import 'dart:async';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  bool _hasMinimumTimeElapsed = false;
  bool _isTranslationLoaded = false;
  bool _isSettingsLoaded = false;
  Timer? _minimumTimeTimer;

  @override
  void initState() {
    super.initState();
    _initializeComponents();
  }

  void _initializeComponents() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _minimumTimeTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hasMinimumTimeElapsed = true;
        _checkAndNavigate();
      });
    });

    _initPackageInfo();
    _loadTranslations();
    _loadSettings();
  }

  void _loadSettings() async {
    final settingsCubit = BlocProvider.of<SettingsCubit>(context);
    await settingsCubit.loadSettings();
    setState(() {
      _isSettingsLoaded = true;
      _checkAndNavigate();
    });
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

  void _checkAndNavigate() {
    if (_hasMinimumTimeElapsed &&
        _isTranslationLoaded &&
        _isSettingsLoaded &&
        mounted) {
      _minimumTimeTimer?.cancel();
      GoRouter.of(context).pushNamed(Routes.logIn.name);
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
        if (state is TranslationLoaded) {
          setState(() {
            _isTranslationLoaded = true;
            _checkAndNavigate();
          });
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
          Center(
            child: Lottie.asset(
              'assets/splash.json',
              controller: _animationController,
              onLoaded: (composition) {
                _animationController
                  ..duration = composition.duration
                  ..forward();
              },
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Container(
            height: size.height * 0.15,
            alignment: Alignment.center,
            child: Text(
              'Version $_version',
              style: GoogleFonts.montserrat(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
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
