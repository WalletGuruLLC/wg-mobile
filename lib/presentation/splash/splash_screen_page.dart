import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late Timer _timer;
  String _version = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _timer = Timer(const Duration(seconds: 1), () {
      GoRouter.of(context).pushNamed(Routes.logIn.name);
    });
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    print('info');
    print(info);
    setState(() {
      _version = '${info.version}+${info.buildNumber}';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WalletGuruLayout(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      showBackButton: false,
      showBottomNavigationBar: true,
      showAppBar: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Image.asset(
            Assets.iconLogoSplash,
            fit: BoxFit.scaleDown,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Version $_version',
          style: const TextStyle(
            fontFamily: 'CenturyGothic',
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
