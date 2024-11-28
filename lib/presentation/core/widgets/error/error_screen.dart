import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/domain/core/auth/auth_service.dart';
import 'package:wallet_guru/infrastructure/core/routes/router_provider.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final AuthService authService = AuthService();
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
              text: l10n.problemModal,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              width: size.width * 0.35,
              border: Border.all(
                  color: AppColorSchema.of(context).buttonBorderColor),
              onPressed: () async {
                await authService.logout();
                GoRouter.of(navigatorKey.currentContext!).go(
                  Routes.logIn.path,
                );
              },
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
