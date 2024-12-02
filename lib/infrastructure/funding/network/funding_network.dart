import 'package:wallet_guru/infrastructure/core/env/env.dart';

class FundingNetwork {
  static final String getListOfIncomingPayments =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/list-incoming-payments';
  static final String linkServerProvider =
      '${Env.baseUrlWs}/api/v1/wallets-rafiki/service-provider-link';
  static final String createIncomingPayment =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/create/incoming-payment';
  static final String unlinkedServiceProvider =
      '${Env.baseUrlWs}/api/v1/wallets-rafiki/service-provider-unlink';
}
