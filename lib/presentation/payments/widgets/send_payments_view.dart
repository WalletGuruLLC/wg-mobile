import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/recieve_payment/receive_payment_cubit.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/wallet_address_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class SendPaymentsView extends StatefulWidget {
  const SendPaymentsView({super.key});

  @override
  State<SendPaymentsView> createState() => _SendPaymentsViewState();
}

class _SendPaymentsViewState extends State<SendPaymentsView> {
  late ReceivePaymentCubit receivePaymentCubit;

  @override
  void initState() {
    receivePaymentCubit = BlocProvider.of<ReceivePaymentCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.25),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextBase(
              text: l10n.scanQR,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(width: 10),
            Image.asset(
              Assets.scanIcon,
              width: 20,
              height: 20,
              color: Colors.white,
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextBase(
          text: l10n.walletAddress,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 5),
        WalletAddressForm(
          specialDecoration: true,
          hintText: l10n.walletAddress,
          validation: false,
          onChanged: (value) {
            receivePaymentCubit.updateSendPaymentInformation(
                receiverWalletAddress: value);
            // Handle the change
          },
        )
      ],
    );
  }
}
