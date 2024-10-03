import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class ScanQRButton extends StatelessWidget {
  const ScanQRButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => GoRouter.of(context).pushNamed(Routes.selectWalletByQr.name),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextBase(
            text: l10n.scanQR,
            fontSize: 15,
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
    );
  }
}
