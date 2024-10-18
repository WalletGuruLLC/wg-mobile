import 'package:wallet_guru/infrastructure/core/env/env.dart';

class LoginNetwork {
  static final String signIn = '${Env.baseUrl}/api/v1/users/signin';
  static final String verifyEmailOtp =
      '${Env.baseUrl}/api/v1/users/verify/otp/mfa';
  static final String resendOtp = '${Env.baseUrl}/api/v1/users/send-otp';
  static final String logOut = '${Env.baseUrl}/api/v1/users/logout';
  static final String forgotPassword =
      '${Env.baseUrl}/api/v1/users/forgot-password';
  static final String changePassword =
      '${Env.baseUrl}/api/v1/users/confirm-password';
}
