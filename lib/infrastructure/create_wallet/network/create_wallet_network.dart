import 'package:wallet_guru/infrastructure/core/env/env.dart';

class CreateWalletNetwork {
  static final String createWallet =
      '${Env.baseUrl}/api/v1/wallets-rafiki/address';
  static final getRafikiAssets = '${Env.baseUrl}/api/v1/wallets-rafiki/assets';
}
