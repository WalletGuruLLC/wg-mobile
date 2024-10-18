import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/appbar/app_top_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/payments/widgets/add_provider/add_provider_view.dart';

class AddProviderPage extends StatelessWidget {
  const AddProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: WalletGuruAppBar(
        title: l10n.addService,
        action: () {
          GoRouter.of(context).pushReplacementNamed(
            Routes.payments.name,
          );
        },
        showSimpleStyle: false,
      ),
      body: const AddProviderByQrView(),
    );
  }
}
