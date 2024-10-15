import 'package:wallet_guru/infrastructure/core/env/env.dart';

class FundingNetwork {
  static final String getListOfIncomingPayments =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/list-incoming-payments';
  static final String linkServerProvider =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/service-provider-link';
}
