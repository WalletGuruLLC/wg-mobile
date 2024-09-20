import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/appbar/app_top_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/payments/widgets/select_wallet/send_payment_by_qr_view.dart';

class SelectWalletByQrPage extends StatelessWidget {
  const SelectWalletByQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: WalletGuruAppBar(
        title: l10n.sendPayment,
        action: () {
          GoRouter.of(context).pushReplacementNamed(
            Routes.payments.name,
          );
        },
        showSimpleStyle: false,
      ),
      body: const Stack(
        children: [
          SendPaymentByQrView(), // Background QR Scanner View
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
