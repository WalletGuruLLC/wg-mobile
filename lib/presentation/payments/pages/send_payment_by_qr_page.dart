import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/widgets/appbar/app_top_bar.dart';

class SendPaymentsPageByQr extends StatelessWidget {
  const SendPaymentsPageByQr({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: WalletGuruAppBar(
            title: 'jajajajaja',
            action: () {},
          ),
        ));
  }
}
