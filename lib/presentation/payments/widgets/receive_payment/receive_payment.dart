import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class ReceivePaymentView extends StatefulWidget {
  const ReceivePaymentView({super.key});

  @override
  State<ReceivePaymentView> createState() => _ReceivePaymentViewState();
}

class _ReceivePaymentViewState extends State<ReceivePaymentView> {
  late SendPaymentCubit sendPaymentCubit;
  late UserCubit userCubit;

  @override
  void initState() {
    sendPaymentCubit = BlocProvider.of<SendPaymentCubit>(context);
    userCubit = BlocProvider.of<UserCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        const String qrUrl = 'https://walletguru.me/account/johndoe';

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, left: 40, right: 40, bottom: 15),
                child: Column(
                  children: [
                    const PrettyQr(
                      data: qrUrl,
                      size: 150,
                      elementColor: Colors.white,
                      roundEdges: true,
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 120,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFF212139),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.download_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextBase(
                  text: qrUrl,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.copy, color: Colors.white),
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: qrUrl));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
