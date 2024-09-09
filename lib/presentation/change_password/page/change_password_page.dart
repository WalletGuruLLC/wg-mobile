import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/change_password/widgets/change_password_form.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showAppBar: false,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height,
            child: const ChangePasswordForm(),
          ),
        ),
      ],
    );
  }
}
