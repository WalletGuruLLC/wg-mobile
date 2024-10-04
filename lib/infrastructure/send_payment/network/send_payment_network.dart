import 'package:wallet_guru/infrastructure/core/env/env.dart';

class SendPaymentNetwork {
  static final String verifyWalletExistence =
      '${Env.baseUrl}/api/v1/wallet/verifyWalletExistence';
  static final String getWalletInformation =
      '${Env.baseUrlWallet}/api/v1/wallets/wallet/token';
  static final String createTransaction =
      '${Env.baseUrl}/api/v1/wallets-rafiki/transaction';
}
