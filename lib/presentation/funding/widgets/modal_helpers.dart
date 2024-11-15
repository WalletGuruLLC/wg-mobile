import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/funding/funding_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

class ModalHelper {
  final BuildContext context;

  ModalHelper(
    this.context,
  );

  Future<dynamic> buildErrorModal(
      String descriptionEn, String descriptionEs, String codeError) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    final locale = Localizations.localeOf(context);
    String description =
        locale.languageCode == 'en' ? descriptionEn : descriptionEs;
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
                text: l10n.successUnlinkedProviderTitle,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: description,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: codeError,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
            BlocProvider.of<FundingCubit>(context)
                .resetCreateIncomingPaymentStatus();
            BlocProvider.of<FundingCubit>(context)
                .resetUnlinkedServiceProviderStatus();
          },
        );
      },
    );
  }

  Future<dynamic> buildSuccessfulModal() {
    Size size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BaseModal(
          isSucefull: true,
          buttonText: "OK",
          buttonWidth: size.width * 0.4,
          content: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.successUnlinkedProviderTitle,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.successUnlinkedProviderText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
            GoRouter.of(context)
                .pushReplacementNamed(Routes.fundingScreen.name);
            BlocProvider.of<FundingCubit>(context)
                .resetUnlinkedServiceProviderStatus();
          },
        );
      },
    );
  }

  Future<dynamic> buildConfirmationModal(String sessionId) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocListener<FundingCubit, FundingState>(
            listener: (context, state) {
              if (state.unlinkedServiceProvider is SubmissionSuccess) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BaseModal(
                      buttonWidth: size.width * 0.4,
                      content: Column(
                        children: [
                          SizedBox(height: size.width * 0.01),
                          TextBase(
                            textAlign: TextAlign.center,
                            text: l10n.successFundsTitle,
                            fontSize: 18,
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
            },
            child: BaseModal(
              isSucefull: false,
              content: Column(
                children: [
                  SizedBox(height: size.height * 0.010),
                  TextBase(
                    textAlign: TextAlign.center,
                    text: l10n.confirmProviderDeletion,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColorSchema.of(context).secondaryText,
                  ),
                  SizedBox(height: size.height * 0.010),
                  TextBase(
                    textAlign: TextAlign.center,
                    text: l10n.confirmProviderText,
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
                  BlocBuilder<FundingCubit, FundingState>(
                    builder: (context, state) {
                      if (state.unlinkedServiceProvider is FormSubmitting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return CustomButton(
                          width: Localizations.localeOf(context).languageCode ==
                                  'en'
                              ? size.height * 0.15
                              : size.height * 0.17,
                          text: "Ok",
                          onPressed: () {
                            Navigator.of(context).pop();
                            context
                                .read<FundingCubit>()
                                .emitUnlinkedServiceProvider(sessionId);
                          },
                        );
                      }
                    },
                  ),
                  CustomButton(
                    color: AppColorSchema.of(context).buttonTertiaryColor,
                    buttonTextColor: Colors.black,
                    width: Localizations.localeOf(context).languageCode == 'en'
                        ? size.height * 0.15
                        : size.height * 0.17,
                    text: l10n.cancel,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
