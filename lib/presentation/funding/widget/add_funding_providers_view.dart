import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/funding/funding_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/amount_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddFundingProviderView extends StatefulWidget {
  const AddFundingProviderView({super.key});

  @override
  State<AddFundingProviderView> createState() => _AddFundingProviderViewState();
}

class _AddFundingProviderViewState extends State<AddFundingProviderView> {
  final TextEditingController _amountController = TextEditingController();
  late FundingCubit fundingCubit;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    fundingCubit = BlocProvider.of<FundingCubit>(context);
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
          _buildInsufficientBalanceModal();
        } else if (state.createIncomingPayment is SubmissionSuccess) {
          GoRouter.of(context).pushReplacementNamed(Routes.home.name);
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
                        walletAddressUrl: 'https://www.walletaddress.com',
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
                onPressed: () => isButtonEnabled ? _callCreateFunding() : null,
              );
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
      _buildInsufficientBalanceModal();
    } else if (balance >= double.parse(_amountController.text)) {
      fundingCubit.emitCreateIncomingPayment();
    }
  }

  // Method to build the successful modal
  Future<dynamic> _buildInsufficientBalanceModal() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return BaseModal(
          buttonText: "OK",
          buttonWidth: size.width * 0.4,
          content: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: "Insufficient Funds",
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text:
                    "It looks like your balance is too low to complete this transaction. Please add funds to your account",
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
}
