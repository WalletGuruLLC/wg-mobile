import 'package:wallet_guru/infrastructure/core/env/env.dart';

class SettingsNetwork {
  static final String getSetting =
      '${Env.baseUrlWallet}/api/v1/settings?belongs=app';
}
