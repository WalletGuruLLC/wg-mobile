import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/funding/funding_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModalHelper {
  final BuildContext context;
  final FundingCubit fundingCubit;

  ModalHelper(
    this.context,
    this.fundingCubit,
  );

  Future<dynamic> buildInsufficientBalanceModal() {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BaseModal(
          buttonText: "OK",
          buttonWidth: size.width * 0.4,
          content: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.insufficientFundsTitle,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.insufficientFundsText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<dynamic> buildConfirmModal(String amount) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BaseModal(
          buttonWidth: size.width * 0.4,
          content: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.confirmFundsTitle,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: '${l10n.confirmFundsText}$amount',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          hasDoubleButton: true,
          doubleButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                width: Localizations.localeOf(context).languageCode == 'en'
                    ? size.height * 0.15
                    : size.height * 0.19,
                text: 'Add',
                onPressed: () {
                  Navigator.of(context).pop();
                  fundingCubit.emitCreateIncomingPayment();
                },
              ),
              CustomButton(
                color: AppColorSchema.of(context).buttonTertiaryColor,
                buttonTextColor: Colors.black,
                width: Localizations.localeOf(context).languageCode == 'en'
                    ? size.height * 0.15
                    : size.height * 0.19,
                text: l10n.cancel,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> buildErrorModal() {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BaseModal(
          buttonText: "OK",
          buttonWidth: size.width * 0.4,
          content: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.errorFundsTitle,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.errorFundsText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<dynamic> buildSuccessfulModal(String amount, String providerName) {
    Size size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BaseModal(
          buttonText: "OK",
          buttonWidth: size.width * 0.4,
          content: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.successFundsTitle,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text:
                    '${l10n.successFundsText}$amount ${l10n.successFundsTextAccount} $providerName',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
            GoRouter.of(context).pushReplacementNamed(Routes.home.name);
          },
        );
      },
    );
  }
}
