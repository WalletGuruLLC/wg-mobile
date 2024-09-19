import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/receive_payment/receive_payment_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/wallet_address_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class SendPaymentsViewByForm extends StatefulWidget {
  const SendPaymentsViewByForm({super.key});

  @override
  State<SendPaymentsViewByForm> createState() => _SendPaymentsViewByFormState();
}

class _SendPaymentsViewByFormState extends State<SendPaymentsViewByForm> {
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
        GestureDetector(
          onTap: () =>
              GoRouter.of(context).pushNamed(Routes.sendPaymentsByQr.name),
          child: Row(
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
              receiverWalletAddress: value,
            );
            // Handle the change
          },
        ),
        SizedBox(height: size.height * 0.25),
        BlocBuilder<ReceivePaymentCubit, ReceivePaymentState>(
            builder: (context, state) {
          bool showButton = state.showButton;
          return showButton
              ? CustomButton(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  borderRadius: 12,
                  color: AppColorSchema.of(context).buttonColor,
                  border: Border.all(width: 0.75, color: Colors.transparent),
                  text: l10n.next,
                  height: 56,
                  onPressed: () {},
                )
              : const SizedBox();
        })
      ],
    );
  }
}
