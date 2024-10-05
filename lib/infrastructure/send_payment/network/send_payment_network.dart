import 'package:wallet_guru/infrastructure/core/env/env.dart';

class SendPaymentNetwork {
  static final String verifyWalletExistence =
      '${Env.baseUrl}/api/v1/wallet/verifyWalletExistence';
  static final String getWalletInformation =
      '${Env.baseUrlWallet}/api/v1/wallets/wallet/token';
  static final String createTransaction =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/transaction';
  static final getRafikiAssets =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/assets';
  static final getExchangeRate =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/exchange-rates';
}
