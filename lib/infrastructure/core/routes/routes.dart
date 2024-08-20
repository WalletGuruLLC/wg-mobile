import 'package:wallet_guru/infrastructure/core/routes/route.dart';

class Routes {
  static final home = Route(path: '/home', name: 'home');
  static final splash = Route(path: '/splash', name: 'splash');
  static final signUp = Route(path: '/signUp', name: 'signUp');
  static final logIn = Route(path: '/logIn', name: 'logIn');
  static final doubleFactorAuth =
      Route(path: '/doubleFactorAuth', name: 'doubleFactorAuth');
  static final dashboard = Route(path: '/dashboard', name: 'dashboard');
  static final createWallet =
      Route(path: '/createWallet', name: 'createWallet');
}
