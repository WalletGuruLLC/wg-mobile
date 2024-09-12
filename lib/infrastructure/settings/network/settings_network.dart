import 'package:wallet_guru/infrastructure/core/env/env.dart';

class SettingsNetwork {
  static final String getSetting = '${Env.baseUrl}/api/v1/settings?belongs=app';
}
