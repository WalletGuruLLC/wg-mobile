import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/payments/widgets/withdraw/withdraw_modal_confirmation.dart';

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
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SendPaymentCubit>(context)
        .emitAddCancelIncoming(widget.listProvider);
  }

  bool isAllFunds = true;

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
                    onPressed: () => (isAllFunds)
                        ? showDialog(
                            context: context,
                            barrierColor:
                                AppColorSchema.of(context).modalBarrierColor,
                            builder: (_) {
                              return const WithdrawModalConfirmation();
                            },
                          )
                        : null,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
