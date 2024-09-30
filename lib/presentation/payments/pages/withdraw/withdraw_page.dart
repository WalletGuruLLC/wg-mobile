import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/amount_form.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  bool isAllFunds = true;

  TextEditingController amountController = TextEditingController();

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
            Routes.payments.name,
          );
        },
        pageAppBarTitle: l10n.sendPayment,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SizedBox(
              width: size.width * 0.90,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBase(
                    text: l10n.availableAmountWithdraw,
                    fontSize: size.width * 0.03,
                  ),
                  TextBase(
                    text: '${availableAmount.toStringAsFixed(2)} USD',
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
                      Radio(
                        value: false,
                        groupValue: isAllFunds,
                        onChanged: (value) {
                          setState(() {
                            isAllFunds = value!;
                          });
                        },
                      ),
                      TextBase(
                        text: l10n.otherAmountWithdraw,
                        fontSize: size.width * 0.035,
                      ),
                    ],
                  ),
                  if (!isAllFunds)
                    AmountForm(
                      controller: amountController,
                      onChanged: (value) {},
                    ),
                  if (isAllFunds)
                    TextBase(
                      text: '${availableAmount.toStringAsFixed(2)} USD',
                      fontSize: size.width * 0.07,
                    ),
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  CustomButton(
                    border: Border.all(
                        color: AppColorSchema.of(context).buttonBorderColor),
                    color: amountController.text.isNotEmpty
                        ? AppColorSchema.of(context).buttonColor
                        : Colors.transparent,
                    text: l10n.butonWithdraw,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    onPressed: () =>
                        isButtonEnabled() ? () => showConfirmDialog() : null,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isButtonEnabled() {
    if (isAllFunds) return true;
    double? amount = double.tryParse(amountController.text);
    return amount != null && amount > 0;
  }

  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Empty Funds'),
          content: Text('Are you sure to empty this amount?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Empty'),
              onPressed: () {
                Navigator.of(context).pop();
                performEmptyFunds();
              },
            ),
          ],
        );
      },
    );
  }

  void performEmptyFunds() {
    // Aquí iría la lógica para vaciar los fondos
    // Por ahora, simplemente mostraremos un diálogo de error
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Empty Funds Error'),
          content: Text(
              'There was an error processing your empty funds. Please try again.'),
          actions: [
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
