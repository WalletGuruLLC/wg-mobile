import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/amount_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/currency_drop_down.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/payments/widgets/send_payment/payment_button.dart';

class SendPaymentToUserView extends StatelessWidget {
  const SendPaymentToUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    final sendPaymentCubit = BlocProvider.of<SendPaymentCubit>(context);

    return BlocConsumer<SendPaymentCubit, SendPaymentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.05),
            // Wallet Address Display
            TextBase(
              text: l10n.walletAddress,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: TextBase(
                text: sendPaymentCubit
                    .state.sendPaymentEntity!.receiverWalletAddress,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            // Amount label
            SizedBox(height: size.height * 0.04),
            TextBase(
              text: l10n.amount,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 10),
            AmountForm(
              controller: TextEditingController(),
              onChanged: (value) {
                sendPaymentCubit.updateSendPaymentInformation(
                  receiverAmount: value,
                );
              },
            ),
            // Select Currency
            SizedBox(height: size.height * 0.04),
            TextBase(
              text: l10n.currency,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 10),
            if (state.fetchWalletAsset == true)
              CurrencyDropDown(
                initialValue: null,
                hintText: l10n.chooseCurrency,
                items: sendPaymentCubit.state.rafikiAssets!
                    .where((e) =>
                        e.code ==
                        'USD') // Filtrar solo los que tengan el código 'USD'
                    .map((e) => e.code)
                    .toList(),
                onChanged: (value) {
                  sendPaymentCubit.updateSendPaymentInformation(
                    currency: value,
                  );
                },
              ),
            SizedBox(height: size.height * 0.10),
            const PaymentButtonWithTimer(),
          ],
        );
      },
    );
  }
}
