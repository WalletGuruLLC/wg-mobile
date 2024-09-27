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
  static final createProfile1 =
      Route(path: '/createProfile1', name: 'createProfile1');
  static final createProfile2 =
      Route(path: '/createProfile2', name: 'createProfile2');
  static final createProfile3 =
      Route(path: '/createProfile3', name: 'createProfile3');
  static final createProfile4 =
      Route(path: '/createProfile4', name: 'createProfile4');
  static final myProfile = Route(path: '/myProfile', name: 'myProfile');
  static final myInfo = Route(path: '/myInfo', name: 'myInfo');
  static final changePassword =
      Route(path: '/changePassword', name: 'changePassword');
  static final payments = Route(path: '/payments', name: 'payments');
  static final selectWalletByForm =
      Route(path: '/selectWalletByForm', name: 'selectWalletByForm');
  static final selectWalletByQr =
      Route(path: '/selectWalletByQr', name: 'selectWalletByQr');
  static final sendPaymentToUser =
      Route(path: '/sendPaymentToUser', name: 'sendPaymentToUser');
  static final sendPayments =
      Route(path: '/sendPayments', name: 'sendPayments');
  static final configurationSettings =
      Route(path: '/configurationSettings', name: 'configurationSettings');
  static final withdrawPage =
      Route(path: '/withdrawPage', name: 'withdrawPage');
  static final receivePayment =
      Route(path: '/receivePayment', name: 'receivePayment');
}
