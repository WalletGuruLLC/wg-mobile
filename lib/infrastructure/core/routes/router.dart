import 'package:go_router/go_router.dart';
import 'package:wallet_guru/presentation/configuration_setting/page/configuration_setting_page.dart';

import 'package:wallet_guru/presentation/home/page/home_page.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/login/pages/login_page.dart';
import 'package:wallet_guru/presentation/payments/pages/payments_page.dart';
import 'package:wallet_guru/presentation/payments/pages/send_payments_page.dart';
import 'package:wallet_guru/presentation/splash/splash_screen_page.dart';
import 'package:wallet_guru/presentation/my_profile/pages/my_info_page.dart';
import 'package:wallet_guru/presentation/my_profile/pages/profile_page.dart';
import 'package:wallet_guru/presentation/register/pages/register_pages.dart';
import 'package:wallet_guru/presentation/login/pages/authentication_page.dart';
import 'package:wallet_guru/presentation/create_wallet/pages/create_wallet.dart';
import 'package:wallet_guru/presentation/change_password/page/change_password_page.dart';
import 'package:wallet_guru/presentation/create_profile/page/create_profile_first_page.dart';
import 'package:wallet_guru/presentation/create_profile/page/create_profile_third_page.dart';
import 'package:wallet_guru/presentation/create_profile/page/create_profile_second_page.dart';
import 'package:wallet_guru/presentation/create_profile/page/create_profile_fourth_page.dart';

class WalletGuruRouter {
  static List<GoRoute> routes = [
    GoRoute(
      name: Routes.home.name,
      path: Routes.home.path,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: Routes.splash.name,
      path: Routes.splash.path,
      builder: (context, state) => const LoginPage(),
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
      name: Routes.myProfile.name,
      path: Routes.myProfile.path,
      builder: (context, state) => const MyProfilePage(),
    ),
    GoRoute(
      name: Routes.myInfo.name,
      path: Routes.myInfo.path,
      builder: (context, state) => const MyInfoPage(),
    ),
    GoRoute(
      name: Routes.changePassword.name,
      path: Routes.changePassword.path,
      builder: (context, state) => const ChangePasswordPage(),
    ),
    GoRoute(
      name: Routes.payments.name,
      path: Routes.payments.path,
      builder: (context, state) => const PaymentsPage(),
    ),
    GoRoute(
      name: Routes.sendPayments.name,
      path: Routes.sendPayments.path,
      builder: (context, state) => const SendPaymentsPage(),
    ),
    GoRoute(
      name: Routes.configurationSettings.name,
      path: Routes.configurationSettings.path,
      builder: (context, state) => const ConfigurationSettingPage(),
    ),
  ];
}
