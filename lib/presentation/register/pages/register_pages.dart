import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/widgets/appbar/appbar_logo_widget.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/register/widgets/register_form.dart';

class RegisterPages extends StatelessWidget {
  const RegisterPages({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showBackButton: false,
      showBottomNavigationBar: false,
      appBar: appBarLogoWidget(context),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
              width: size.width * 0.90,
              height: size.height,
              child: const RegisterForm()),
        ),
      ],
    );
  }
}
