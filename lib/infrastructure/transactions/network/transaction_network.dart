import 'package:wallet_guru/infrastructure/core/env/env.dart';

class TransactionNetwork {
  static final String getListUserTransactions =
      '${Env.baseUrlWallet}/api/v1/wallets-rafiki/list-transactions';
}
