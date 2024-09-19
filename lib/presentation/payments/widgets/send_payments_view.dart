import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class SendPaymentsView extends StatelessWidget {
  const SendPaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.30),
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
      ],
    );
  }
}
