import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LockAccountModal extends StatelessWidget {
  const LockAccountModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    final bool isWalletAvailable =
        BlocProvider.of<UserCubit>(context).state.wallet!.walletDb.active;

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
            text: isWalletAvailable
                ? l10n.lockAccountModalTitle
                : l10n.unLockWalletModalTitle,
            fontSize: 20,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
          ),
          TextBase(
            text: isWalletAvailable
                ? l10n.lockAccountConfirmation
                : l10n.unlockAccountConfirmation,
            fontSize: 14,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
          TextBase(
            textAlign: TextAlign.center,
            text: isWalletAvailable
                ? l10n.lockAccountConfirmationText
                : l10n.unlockAccountConfirmationText,
            fontSize: 14,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state.formStatusLockAccount is SubmissionSuccess) {
                    Navigator.of(context).pop();
                    context.read<UserCubit>().resetFormStatusLockAccount();
                  } else if (state.formStatusLockAccount is SubmissionFailed) {
                    Navigator.of(context).pop();
                    context.read<UserCubit>().resetFormStatusLockAccount();
                  }
                },
                builder: (context, state) {
                  if (state.formStatusLockAccount is FormSubmitting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return CustomButton(
                      isModal: true,
                      borderRadius: 12,
                      width: size.width * 0.33,
                      border: Border.all(
                        color: AppColorSchema.of(context)
                            .secondaryButtonBorderColor,
                      ),
                      color: AppColorSchema.of(context).buttonColor,
                      text: l10n.button_pop_up_sucefull,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        context.read<UserCubit>().emitLockAccount();
                      },
                    );
                  }
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
                text: l10n.deny,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                buttonTextColor: Colors.black,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
