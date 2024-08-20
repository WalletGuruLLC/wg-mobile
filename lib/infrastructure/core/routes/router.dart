import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/create_wallet/pages/create_wallet.dart';
import 'package:wallet_guru/presentation/login/pages/authentication_page.dart';
import 'package:wallet_guru/presentation/login/pages/login_page.dart';
import 'package:wallet_guru/presentation/register/pages/register_pages.dart';
import 'package:wallet_guru/presentation/splash/splash_screen_page.dart';

class WalletGuruRouter {
  static List<GoRoute> routes = [
    GoRoute(
      name: Routes.home.name,
      path: Routes.home.path,
      builder: (context, state) => const SplashScreenPage(),
    ),
    GoRoute(
      name: Routes.splash.name,
      path: Routes.splash.path,
      builder: (context, state) => const SplashScreenPage(),
    ),
    GoRoute(
      name: Routes.signUp.name,
      path: Routes.signUp.path,
      builder: (context, state) => const RegisterPages(),
    ),
    GoRoute(
      name: Routes.logIn.name,
      path: Routes.logIn.path,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: Routes.doubleFactorAuth.name,
      path: Routes.doubleFactorAuth.path,
      builder: (context, state) => const AuthenticationPage(),
    ),
    GoRoute(
      name: Routes.createWallet.name,
      path: Routes.createWallet.path,
      builder: (context, state) => const CreateWalletPage(),
    ),
  ];
}
