import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/wallet_address_form.dart';
import 'package:wallet_guru/presentation/payments/widgets/select_wallet/select_wallet_next_button.dart';
import 'package:wallet_guru/presentation/payments/widgets/select_wallet/select_wallet_scan_qr_option.dart';

class SelectWalletByFormView extends StatefulWidget {
  const SelectWalletByFormView({super.key});

  @override
  State<SelectWalletByFormView> createState() => _SelectWalletByFormViewState();
}

class _SelectWalletByFormViewState extends State<SelectWalletByFormView> {
  late SendPaymentCubit sendPaymentCubit;

  @override
  void initState() {
    sendPaymentCubit = BlocProvider.of<SendPaymentCubit>(context);
    sendPaymentCubit.emitGetWalletInformation();
    sendPaymentCubit.emitFetchWalletAsset();
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
        SizedBox(height: size.height * 0.02),
        const ScanQRButton(),
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
            sendPaymentCubit.updateSendPaymentInformation(
              receiverWalletAddress: value,
            );
            sendPaymentCubit.emitGetExchangeRate();

            // Handle the change
          },
        ),
        const SizedBox(height: 5),
        TextBase(
          text: l10n.exampleWalletAddress,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: size.height * 0.25),
        const SelectWalletNextButton()
      ],
    );
  }
}
