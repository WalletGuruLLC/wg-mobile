import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'BASE_URL_WALLET', obfuscate: true)
  static final String baseUrlWallet = _Env.baseUrlWallet;

  @EnviedField(varName: 'BASE_URL_CODES', obfuscate: true)
  static final String baseUrlCodes = _Env.baseUrlCodes;

  @EnviedField(varName: 'SUM_SUB_API_TOKEN', obfuscate: true)
  static final String sumSubApiToken = _Env.sumSubApiToken;

  @EnviedField(varName: 'SUM_SUB_API_SECRET', obfuscate: true)
  static final String sumSubApiSecret = _Env.sumSubApiSecret;

  @EnviedField(varName: 'SUM_SUB_LEVEL_NAME', obfuscate: true)
  static final String sumSubLevelName = _Env.sumSubLevelName;
}
