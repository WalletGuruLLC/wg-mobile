import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/login/widgets/authentication_form.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showAppBar: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: SizedBox(
          width: size.width * 0.90,
          height: size.height,
          child: const AuthenticationForm(),
        ),
      ),
    );
  }
}
