import 'package:wallet_guru/infrastructure/core/env/env.dart';

class UserNetwork {
  static final String getCurrentUserInformation =
      '${Env.baseUrl}/api/v1/users/current-user';
  static final String changePassword =
      '${Env.baseUrl}/api/v1/users/change-password';
  static final String updateCreatedUser = '${Env.baseUrl}/api/v1/users/';
  static final String lockAccount = '${Env.baseUrlWallet}/api/v1/wallets/';
  static final String getWalletInformation =
      '${Env.baseUrlWallet}/api/v1/wallets/wallet/token';
  static final String updateUserPicture =
      '${Env.baseUrl}/api/v1/users/upload-image/';
}
