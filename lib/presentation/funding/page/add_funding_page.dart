import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';

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

  TextEditingController amountController = TextEditingController();

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
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      checkColor: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.6),
                CustomButton(
                  border: Border.all(
                      color: AppColorSchema.of(context).buttonBorderColor),
                  color: isChecked
                      ? AppColorSchema.of(context).buttonColor
                      : Colors.transparent,
                  text: l10n.fundingTitelPage,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  onPressed: () => isChecked ? _buildErrorModal() : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
