// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/funding/funding_cubit.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/amount_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/funding/widgets/modals_response.dart';

class AddFundingProviderView extends StatefulWidget {
  String title;
  AddFundingProviderView({
    super.key,
    required this.title,
  });

  @override
  State<AddFundingProviderView> createState() => _AddFundingProviderViewState();
}

class _AddFundingProviderViewState extends State<AddFundingProviderView> {
  final TextEditingController _amountController = TextEditingController();
  late FundingCubit fundingCubit;
  late SendPaymentCubit sendPaymentCubit;
  late ModalHelper modalHelper; // Instancia de ModalHelper
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    fundingCubit = BlocProvider.of<FundingCubit>(context);
    sendPaymentCubit = BlocProvider.of<SendPaymentCubit>(context);
    modalHelper =
        ModalHelper(context, fundingCubit); // Inicialización de ModalHelper
    _amountController.addListener(_validateAmount);
  }

  void _validateAmount() {
    final amount = double.tryParse(_amountController.text);
    setState(() {
      amount != null && amount > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<FundingCubit, FundingState>(
      listener: (context, state) {
        if (state.createIncomingPayment is SubmissionFailed) {
          modalHelper.buildErrorModal(
              state.customMessage,
              state.customMessageEs,
              state.customCode); // Llamada al modal de error
        } else if (state.createIncomingPayment is SubmissionSuccess) {
          modalHelper.buildSuccessfulModal(
            _amountController.text,
            widget.title,
          ); // Llamada al modal de éxito
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.05),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AmountForm(
                    controller: _amountController,
                    onChanged: (value) {
                      fundingCubit.updateFundingEntity(
                        amountToAddFund: value,
                        walletAddressUrl:
                            sendPaymentCubit.state.selectedWalletUrl,
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: TextBase(
                    text: 'USD',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.6),
          BlocBuilder<FundingCubit, FundingState>(
            builder: (context, state) {
              if (state.createIncomingPayment is FormSubmitting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                bool isButtonEnabled = state.isFundingButtonVisible;
                return CustomButton(
                  border: Border.all(
                      color: AppColorSchema.of(context).buttonBorderColor),
                  color: isButtonEnabled
                      ? AppColorSchema.of(context).buttonColor
                      : Colors.transparent,
                  text: l10n.addFundsFundingItem,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  onPressed: () =>
                      isButtonEnabled ? _callCreateFunding() : null,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _callCreateFunding() {
    double balance = BlocProvider.of<UserCubit>(context).state.balance;
    if (balance < double.parse(_amountController.text)) {
      modalHelper
          .buildInsufficientBalanceModal(); // Llamada al modal de saldo insuficiente
    } else if (balance >= double.parse(_amountController.text)) {
      modalHelper.buildConfirmModal(
          _amountController.text); // Llamada al modal de confirmación
    }
  }
}
