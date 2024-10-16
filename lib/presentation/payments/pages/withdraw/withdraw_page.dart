import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({
    super.key,
    required this.totalAmount,
    required this.listProvider,
  });

  final String totalAmount;
  final List<String> listProvider;

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  bool isAllFunds = true;

  double availableAmount = 30.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: WalletGuruLayout(
        showSafeArea: true,
        showSimpleStyle: false,
        showLoggedUserAppBar: true,
        showBottomNavigationBar: false,
        actionAppBar: () {
          GoRouter.of(context).pushReplacementNamed(
            Routes.fundingScreen.name,
          );
        },
        pageAppBarTitle: l10n.withdrawTitelPage,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SizedBox(
              width: size.width * 0.90,
              height: size.height * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBase(
                    text: l10n.availableAmountWithdraw,
                    fontSize: size.width * 0.03,
                  ),
                  TextBase(
                    text:
                        "${toCurrencyString(widget.totalAmount, leadingSymbol: '\$')} USD",
                    fontSize: size.width * 0.07,
                  ),
                  const SizedBox(height: 20),
                  TextBase(
                    text: l10n.selectTheValueWithdraw,
                    fontSize: size.width * 0.035,
                  ),
                  Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: isAllFunds,
                        onChanged: (value) {
                          setState(() {
                            isAllFunds = value!;
                          });
                        },
                      ),
                      TextBase(
                        text: l10n.allFundsWithdraw,
                        fontSize: size.width * 0.035,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  CustomButton(
                    border: Border.all(
                        color: AppColorSchema.of(context).buttonBorderColor),
                    color: (isAllFunds)
                        ? AppColorSchema.of(context).buttonColor
                        : Colors.transparent,
                    text: l10n.butonWithdraw,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    onPressed: () => (isAllFunds) ? _buildErrorModal() : null,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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
