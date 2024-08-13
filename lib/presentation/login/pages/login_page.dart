import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/login/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WalletGuruLayout(
      showAppBar: false,
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height,
          child: const LoginForm(),
        ),
      ),
    );
  }
}
