import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WalletGuruLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Image.asset(
              Assets.iconLogoSplash,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
      showBackButton: false,
      showBottomNavigationBar: true,
      showAppBar: false,
    );
  }
}
