import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wallet_guru/domain/core/auth/auth_service.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/application/settings/settings_cubit.dart';
import 'package:wallet_guru/application/translations_error/translation_error_state.dart';
import 'package:wallet_guru/application/translations_error/translation_error_cubit.dart';
import 'package:wallet_guru/presentation/splash/splash_animation.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String _version = '';
  bool _isAnimationComplete = false;
  bool _isTranslationLoaded = false;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _loadTranslations();
    BlocProvider.of<SettingsCubit>(context).loadSettings();
  }

  void _loadTranslations() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String deviceLanguage = _authService.getDeviceLanguage();
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
    debugPrint('_isAnimationComplete $_isAnimationComplete');
    debugPrint('_isTranslationLoaded $_isTranslationLoaded');
    debugPrint('mounted $mounted');

    if (_isAnimationComplete && _isTranslationLoaded && mounted) {
      GoRouter.of(context).pushNamed(Routes.logIn.name);
    }
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
          SizedBox(
            width: size.width * 0.85,
            child: Center(
              child: SplashAnimation(
                onAnimationComplete: () {
                  setState(() {
                    _isAnimationComplete = true;
                    _checkAndNavigate();
                  });
                },
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
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
