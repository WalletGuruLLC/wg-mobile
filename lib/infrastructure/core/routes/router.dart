import 'package:wallet_guru/main.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/register/register_pages.dart';
import 'package:wallet_guru/presentation/splash/splash_screen_page.dart';

class WalletGuruRouter {
  static List<GoRoute> routes = [
    GoRoute(
      name: Routes.home.name,
      path: Routes.home.path,
      builder: (context, state) => const MyHomePage(
        title: 'hola',
      ),
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
      builder: (context, state) => const MyHomePage(
        title: 'hola',
      ),
    ),
  ];
}
