import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/email_form.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  void submin(String a, bool b) {}

  @override
  Widget build(BuildContext context) {
    return WalletGuruLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset(
                Assets.iconLogoSplash,
                fit: BoxFit.scaleDown,
              ),
            ),
            EmailForm(
              labelText: 'Prueba Registro',
            ),
          ],
        ),
      ),
      showBackButton: false,
      showBottomNavigationBar: true,
      showAppBar: false,
    );
  }
}
