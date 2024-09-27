import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/payments/widgets/receive_payment/receive_payment.dart';

class ReceivePaymentPage extends StatelessWidget {
  const ReceivePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: WalletGuruLayout(
        showSafeArea: true,
        showSimpleStyle: false,
        showLoggedUserAppBar: true,
        showBottomNavigationBar: true,
        actionAppBar: () {
          GoRouter.of(context).pushNamed(
            Routes.payments.name,
          );
        },
        pageAppBarTitle: l10n.receivePayment,
        children: [
          SizedBox(
            width: size.width * 0.90,
            height: size.height,
            child: const ReceivePaymentView(),
          ),
        ],
      ),
    );
  }
}
