import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:wallet_guru/domain/core/auth/auth_service.dart';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isDeviceSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (e) {
      debugPrint('Error checking device support: $e');
      return false;
    }
  }

  Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      debugPrint('Error checking biometrics: $e');
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      debugPrint('Error fetching available biometrics: $e');
      return <BiometricType>[];
    }
  }

  Future<bool> authenticate(String reason) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      debugPrint('Authentication error: $e');
      return false;
    }
  }

  Future authenticateWithBiometric() async {
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticate(
          localizedReason: 'Authenticate to access Wallet Guru',
          options: const AuthenticationOptions(
            biometricOnly: true,
          ));
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return;
    }
    if (authenticated) {
      AuthService().checkTokenExpiration();
    }
  }
}
