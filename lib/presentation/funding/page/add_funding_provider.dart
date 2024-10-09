import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/amount_form.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class AddFundsProvider extends StatefulWidget {
  const AddFundsProvider({
    super.key,
    required this.title,
  });

  final String title;

  @override
  _AddFundsProviderState createState() => _AddFundsProviderState();
}

class _AddFundsProviderState extends State<AddFundsProvider> {
  final TextEditingController _amountController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_validateAmount);
  }

  void _validateAmount() {
    final amount = double.tryParse(_amountController.text);
    setState(() {
      _isButtonEnabled = amount != null && amount > 0;
    });
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
      actionAppBar: () {
        GoRouter.of(context).pushReplacementNamed(
          Routes.fundingScreen.name,
        );
      },
      pageAppBarTitle: widget.title + l10n.addFundsFundingItem,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height * 0.80,
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
                            /*sendPaymentCubit.updateSendPaymentInformation(
                                receiverAmount: value,
                              );*/
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
                CustomButton(
                  border: Border.all(
                      color: AppColorSchema.of(context).buttonBorderColor),
                  color: _isButtonEnabled
                      ? AppColorSchema.of(context).buttonColor
                      : Colors.transparent,
                  text: l10n.addFundsFundingItem,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  onPressed: () => _isButtonEnabled ? _buildErrorModal() : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  // Method to build the successful modal
  Future<dynamic> _buildErrorModal() {
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
                text:
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
