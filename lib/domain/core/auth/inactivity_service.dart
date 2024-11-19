import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallet_guru/domain/core/auth/auth_service.dart';
import 'package:wallet_guru/infrastructure/core/routes/router_provider.dart';

class InactivityService with WidgetsBindingObserver {
  static const int _timeoutDuration = 10 * 60; // 10 minutes in seconds
  Timer? _inactivityTimer;
  Timer? _printTimer;
  final AuthService _authService = AuthService();

  void startTimer(BuildContext context) {
    _inactivityTimer?.cancel();
    _printTimer?.cancel();

    int secondsRemaining = _timeoutDuration;

    _inactivityTimer = Timer(const Duration(seconds: _timeoutDuration), () {
      _logoutUser(context);
    });

    _printTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsRemaining--;
      debugPrint('Seconds remaining: $secondsRemaining');
      if (secondsRemaining <= 0) {
        _printTimer?.cancel();
        debugPrint('Print timer cancelled because time is up');
      }
    });

    debugPrint('Timers started');
  }

  void resetTimer(BuildContext context) {
    debugPrint('Timer reset');
    startTimer(context);
  }

  void _logoutUser(BuildContext context) async {
    await _authService.logout();
    debugPrint('App Closed due to inactivity');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    handleAppLifecycleStateChange(state, navigatorKey.currentContext!);
  }

  void dispose() {
    _inactivityTimer?.cancel();
    _printTimer?.cancel();
    debugPrint('Timers disposed');
  }

  void handleAppLifecycleStateChange(
      AppLifecycleState state, BuildContext context) {
    debugPrint('AppLifecycleState: $state');
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      startTimer(context);
      debugPrint('TI get here');
    } else if (state == AppLifecycleState.resumed) {
      resetTimer(context);
    }
  }
}
