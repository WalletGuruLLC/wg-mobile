import 'package:wallet_guru/infrastructure/core/env/env.dart';

class SendPaymentNetwork {
  static final String baseRafiki =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/';
  static final String verifyWalletExistence =
      '${Env.baseUrlWallet}/api/v1/wallets/exist';
  static final String getWalletInformation =
      '${Env.baseUrlWallet}/api/v1/wallets/wallet/token';
  static final String createTransaction =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/transaction';
  static final getRafikiAssets =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/assets';
  static final getExchangeRate =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/exchange-rates';
  static final getListIncomingPayment =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/list-incoming-payments';
  static final getLinkedProviders =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/linked-providers';
}
