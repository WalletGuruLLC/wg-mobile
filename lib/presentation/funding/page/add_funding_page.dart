import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/deposit/deposit_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class AddFundingPage extends StatefulWidget {
  const AddFundingPage({super.key});

  @override
  State<AddFundingPage> createState() => _AddFundingPageState();
}

class _AddFundingPageState extends State<AddFundingPage> {
  bool isChecked = false;
  late DepositCubit depositCubit;

  @override
  void initState() {
    depositCubit = BlocProvider.of<DepositCubit>(context);
    depositCubit.emitAddFirstFunding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showSimpleStyle: false,
      showLoggedUserAppBar: true,
      showBottomNavigationBar: false,
      actionAppBar: () => Navigator.pop(context),
      pageAppBarTitle: l10n.fundingTitelPage,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height * 0.80,
            child: Column(
              children: [
                Row(
                  children: [
                    TextBase(
                      text:
                          "${toCurrencyString("10", leadingSymbol: '\$')} USD",
                      fontSize: size.width * 0.05,
                    ),
                    Radio(
                      value: true,
                      groupValue: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      activeColor: AppColorSchema.of(context).tertiaryText,
                      fillColor: WidgetStateProperty.resolveWith(
                        (states) => states.contains(WidgetState.selected)
                            ? AppColorSchema.of(context).tertiaryText
                            : AppColorSchema.of(context).primaryText,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.6),
                BlocConsumer<DepositCubit, DepositState>(
                  listener: (context, state) {
                    if (state.formStatus is SubmissionSuccess) {
                      _buildSuccessfulModal(context);
                    } else if (state.formStatus is SubmissionFailed) {
                      _buildModal(
                          //state.customMessage,
                          //state.customMessageEs,
                          //state.customCode,
                          //locale,
                          );
                    }
                  },
                  builder: (context, state) {
                    if (state.formStatus is FormSubmitting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return CustomButton(
                        border: Border.all(
                            color:
                                AppColorSchema.of(context).buttonBorderColor),
                        color: isChecked
                            ? AppColorSchema.of(context).buttonColor
                            : Colors.transparent,
                        text: l10n.fundingTitelPage,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        onPressed: () => _onButtonPressed(state),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Method to handle button actions
  void _onButtonPressed(DepositState state) {
    if (isChecked && state.firstFunding) {
      setState(() {
        depositCubit.emitCreateDepositWallet();
      });
    } else {
      _buildModal(descripcion: "Ya supero el limite de deposito.");
    }
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
                text: l10n.fundsAddedSuccessfully,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.fundsAddedSuccessfullyDescription,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            BlocProvider.of<DepositCubit>(context).emitResetDeposit();

            Navigator.of(context).pop();
            GoRouter.of(context).pushReplacementNamed(
              Routes.home.name,
            );
          },
        );
      },
    );
  }

  // Method to build the successful modal
  Future<dynamic> _buildModal({String? descripcion}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          content: Column(
            children: [
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: descripcion ??
                    "There was an error processing your fund. Please try again.",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: "Error Code:XXXX",
                fontSize: 10,
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
}
