import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class WithdrawModalConfirmation extends StatelessWidget {
  const WithdrawModalConfirmation({
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
            text: l10n.withdrawTitelPopUp,
            fontSize: 20,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
          ),
          TextBase(
            text: l10n.withdrawDescriptionPopUp,
            fontSize: 14,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocConsumer<SendPaymentCubit, SendPaymentState>(
                listener: (context, state) {
                  if (state.formStatusincomingCancel is SubmissionSuccess) {
                    Navigator.of(context).pop();
                    _buildSuccessfulModal(context);
                  } else if (state.formStatusincomingCancel
                      is SubmissionFailed) {
                    _buildErrorModal(context, state.customCode);
                  }
                },
                builder: (context, state) {
                  if (state.formStatusincomingCancel is FormSubmitting) {
                    return const CircularProgressIndicator();
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
                      text: l10n.yes,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        BlocProvider.of<SendPaymentCubit>(context)
                            .emitGetListCancelIncoming();
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

  // Método para construir el modal exitoso
  Future<dynamic> _buildSuccessfulModal(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = AppLocalizations.of(context)!;
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          isSucefull: true,
          buttonText: 'Ok',
          buttonWidth: MediaQuery.of(context).size.width * 0.35,
          content: Column(
            children: [
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.withdrawTitelPopUpSuccessful,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.withdrawDescriptionPopUpSuccessful,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            BlocProvider.of<SendPaymentCubit>(context)
                .resetFormStatusWithdraw();
            Navigator.of(context).pop();
            GoRouter.of(context).pushReplacementNamed(
              Routes.home.name,
            );
          },
        );
      },
    );
  }

  // Placeholder para el método del modal de error
  void _buildErrorModal(BuildContext context, String codeError) {
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          buttonWidth: locale.languageCode == 'en'
              ? MediaQuery.of(context).size.width * 0.40
              : MediaQuery.of(context).size.width * 0.42,
          isSucefull: false,
          content: Column(
            children: [
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.withdrawTitelPopUpError,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.withdrawDescriptionPopUpError,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: "Code: $codeError",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
            ],
          ),
          onPressed: () {
            BlocProvider.of<SendPaymentCubit>(context)
                .resetFormStatusWithdraw();
            Navigator.of(context).pop();
            GoRouter.of(context).pushReplacementNamed(
              Routes.home.name,
            );
          },
        );
      },
    );
  }
}
