import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showBackButton: false,
      showBottomNavigationBar: false,
      showLoggedUserAppBar: false,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: AppColorSchema.of(context).primaryText,
            ),
            const SizedBox(height: 16),
            TextBase(
              text: 'A problem occurred, try again later',
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              border: Border.all(
                  color: AppColorSchema.of(context).buttonBorderColor),
              onPressed: () => GoRouter.of(context).go(
                Routes.logIn.path,
              ),
              text: 'Ok',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ],
    );
  }
}
