import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class PaymentButtonWithTimer extends StatefulWidget {
  const PaymentButtonWithTimer({super.key});

  @override
  State<PaymentButtonWithTimer> createState() => _PaymentButtonWithTimerState();
}

class _PaymentButtonWithTimerState extends State<PaymentButtonWithTimer> {
  Timer? _timer;
  int _remainingSeconds = 60;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SendPaymentCubit, SendPaymentState>(
      builder: (context, state) {
        bool showButton = state.showPaymentButton;

        if (showButton && _timer == null) {
          _startTimer();
        }

        return showButton
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBase(
                    text: l10n.exchangeRateUpdate,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 10),
                  TextBase(
                    text: l10n.convertCurrency,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  TextBase(
                    text: l10n.convertCurrency,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  TextBase(
                    text: l10n.currentExchangeRate,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  TextBase(
                    text: l10n.amountInUsd,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 10),
                  TextBase(
                    color: AppColorSchema.of(context).tertiaryText,
                    text:
                        '${l10n.rateAvailable} ${_formatTime(_remainingSeconds)}',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    borderRadius: 14,
                    color: AppColorSchema.of(context).buttonColor,
                    border: Border.all(width: 0.75, color: Colors.transparent),
                    text: l10n.sendPayment,
                    height: 56,
                    onPressed: () {},
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
