import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class SelectWalletNextButton extends StatelessWidget {
  const SelectWalletNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<SendPaymentCubit, SendPaymentState>(
      listener: (context, state) {
        if (state.isWalletExistForm is SubmissionSuccess) {
          GoRouter.of(context).goNamed(Routes.sendPaymentToUser.name);
        } else if (state.isWalletExistForm is SubmissionFailed) {
          _buildErrorModal(context);
        }
      },
      builder: (context, state) {
        final bool showButton = state.showNextButton;
        return showButton
            ? CustomButton(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                borderRadius: 12,
                color: AppColorSchema.of(context).buttonColor,
                border: Border.all(width: 0.75, color: Colors.transparent),
                text: l10n.next,
                height: 56,
                onPressed: () {
                  SendPaymentCubit sendPaymentCubit =
                      BlocProvider.of<SendPaymentCubit>(context);
                  sendPaymentCubit.emitVerifyWalletExistence('form');
                },
              )
            : const SizedBox();
      },
    );
  }

  void _buildErrorModal(
    BuildContext context,
  ) {
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
                text: l10n.walletNotFoundTitle,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.walletNotFoundText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
