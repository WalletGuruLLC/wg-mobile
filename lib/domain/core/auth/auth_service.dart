import 'package:flutter/widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/router_provider.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/infrastructure/login/data_sources/login_data_sources.dart';

class AuthService {
  String getDeviceLanguage() {
    final String deviceLocale =
        WidgetsBinding.instance.window.locales.first.languageCode;
    return Intl.canonicalizedLocale(deviceLocale);
  }

  bool isExpired(String token) {
    final DateTime? expirationDate = Jwt.getExpiryDate(token);
    if (expirationDate != null) {
      return DateTime.now().toUtc().isAfter(expirationDate);
    } else {
      return false;
    }
  }

  Future<void> checkTokenExpiration() async {
    final storage = await SharedPreferences.getInstance();
    final String? token = storage.getString('Basic');
    if (token == null) return;

    final bool tokenIsExpired = isExpired(token);
    if (tokenIsExpired) {
      await LoginDataSource().refreshToken();
    }
  }

  Future<void> setInitialRoute(BuildContext context) async {
    final storage = await SharedPreferences.getInstance();
    final String? basic = storage.getString('Basic');
    final bool? isWalletCreated = storage.getBool('isWalletCreated');

    if (basic != null && isWalletCreated == false) {
      GoRouter.of(context).pushNamed(Routes.home.name);
    } else {
      GoRouter.of(context).pushNamed(Routes.logIn.name);
    }
  }

  Future<void> logout() async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove('Basic');
    storage.remove('isWalletCreated');
    storage.remove('refreshToken');
    storage.remove('firstFunding');
    final uniqueValue = DateTime.now().millisecondsSinceEpoch;
    router.go('${Routes.splash.path}?forceRebuild=$uniqueValue');
  }
}
