import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/register/widgets/register_form.dart';

class RegisterPages extends StatelessWidget {
  const RegisterPages({super.key});

  @override
  Widget build(BuildContext context) {
    return WalletGuruLayout(
      showBackButton: false,
      showBottomNavigationBar: true,
      showAppBar: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Image.asset(
                Assets.iconLogo,
              ),
              const RegisterForm()
            ],
          ),
        ),
      ],
    );
  }
}
