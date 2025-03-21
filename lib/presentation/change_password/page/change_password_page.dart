import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/change_password/widgets/change_password_form.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    Size size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          GoRouter.of(context).pushReplacementNamed(Routes.myProfile.name);
        }
      },
      child: WalletGuruLayout(
        showSafeArea: true,
        showBackButton: false,
        showLoggedUserAppBar: true,
        pageAppBarTitle: l10n.myProfile,
        actionAppBar: () {
          GoRouter.of(context).pushNamed(
            Routes.myProfile.name,
          );
        },
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
      ),
    );
  }
}
