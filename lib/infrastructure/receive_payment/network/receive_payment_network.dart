import 'package:wallet_guru/infrastructure/core/env/env.dart';

class ReceivePaymentNetwork {
  static final String verifyWalletExistence =
      '${Env.baseUrl}/api/v1/wallet/verifyWalletExistence';
}
