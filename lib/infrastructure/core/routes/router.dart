import 'package:go_router/go_router.dart';

import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/login/pages/login_page.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_page.dart';
import 'package:wallet_guru/presentation/splash/splash_screen_page.dart';
import 'package:wallet_guru/presentation/register/pages/register_pages.dart';
import 'package:wallet_guru/presentation/login/pages/authentication_page.dart';
import 'package:wallet_guru/presentation/create_wallet/pages/create_wallet.dart';
import 'package:wallet_guru/presentation/dashboard_wallet/page/dashboard_wallet_page.dart';
import 'package:wallet_guru/presentation/create_profile/page/create_profile_first_page.dart';
import 'package:wallet_guru/presentation/create_profile/page/create_profile_third_page.dart';
import 'package:wallet_guru/presentation/create_profile/page/create_profile_second_page.dart';
import 'package:wallet_guru/presentation/create_profile/page/create_profile_fourth_page.dart';

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
      builder: (context, state) => const CreateWalletPage(),
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
        builder: (context, state) {
          final String email = state.extra as String;
          return AuthenticationPage(email: email);
        }),
    GoRoute(
      name: Routes.createWallet.name,
      path: Routes.createWallet.path,
      builder: (context, state) => const CreateWalletPage(),
    ),
    GoRoute(
        name: Routes.createProfile1.name,
        path: Routes.createProfile1.path,
        builder: (context, state) {
          final params =
              (state.extra ?? <String, dynamic>{}) as Map<String, dynamic>;
          final id = params['id'] as String;
          final email = params['email'] as String;
          return CreateProfileFirstPage(id: id, email: email);
        }),
    GoRoute(
      name: Routes.createProfile2.name,
      path: Routes.createProfile2.path,
      builder: (context, state) => const CreateProfileSecondPage(),
    ),
    GoRoute(
      name: Routes.createProfile3.name,
      path: Routes.createProfile3.path,
      builder: (context, state) => const CreateProfileThirdPage(),
    ),
    GoRoute(
      name: Routes.createProfile4.name,
      path: Routes.createProfile4.path,
      builder: (context, state) => const CreateProfileFourthPage(),
    ),
    GoRoute(
      name: Routes.dashboardWallet.name,
      path: Routes.dashboardWallet.path,
      builder: (context, state) => const DashboardWalletPage(),
    ),
    GoRoute(
      name: Routes.myProfile.name,
      path: Routes.myProfile.path,
      builder: (context, state) => const MyProfilePage(),
    ),
  ];
}
