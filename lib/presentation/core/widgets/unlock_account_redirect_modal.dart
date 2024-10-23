import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class LockAccountRedirectModal extends StatelessWidget {
  const LockAccountRedirectModal({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return BaseModal(
      hasActions: true,
      isSucefull: false,
      centerIcon: Container(),
      hasDoubleButton: true,
      doubleButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            isModal: true,
            borderRadius: 12,
            width: size.width * 0.33,
            border: Border.all(
              color: AppColorSchema.of(context).secondaryButtonBorderColor,
            ),
            color: AppColorSchema.of(context).buttonColor,
            text: l10n.goToProfile,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            onPressed: () {
              GoRouter.of(context).pushNamed(
                Routes.myProfile.name,
              );
            },
          ),
          CustomButton(
            isModal: true,
            borderRadius: 12,
            width: size.width * 0.33,
            border: Border.all(
              color: AppColorSchema.of(context).secondaryButtonBorderColor,
            ),
            color: AppColorSchema.of(context).clearButtonColor,
            text: l10n.cancel,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            buttonTextColor: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          TextBase(
            textAlign: TextAlign.center,
            text: l10n.walletLocked,
            fontSize: 20,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 10),
          TextBase(
            text: l10n.firstUnlockWallet,
            fontSize: 14,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
