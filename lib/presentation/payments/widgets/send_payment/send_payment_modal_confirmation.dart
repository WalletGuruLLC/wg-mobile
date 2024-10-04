import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendPaymentModalConfirmation extends StatelessWidget {
  const SendPaymentModalConfirmation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return BaseModal(
      showCloseIcon: true,
      hasActions: false,
      centerIcon: Container(),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Icon(
            Icons.warning_amber_sharp,
            color: AppColorSchema.of(context).buttonColor,
          ),
          const SizedBox(height: 10),
          TextBase(
            textAlign: TextAlign.center,
            text: l10n.confirmPaymentTitle,
            fontSize: 20,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
          ),
          TextBase(
            text: l10n.confirmPaymentText1,
            fontSize: 14,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
          TextBase(
            textAlign: TextAlign.center,
            text: l10n.confirmPaymentText2,
            fontSize: 14,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 10),
          Row(
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
                text: l10n.yes,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                onPressed: () {
                  Navigator.of(context).pop();
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
          )
        ],
      ),
    );
  }
}
