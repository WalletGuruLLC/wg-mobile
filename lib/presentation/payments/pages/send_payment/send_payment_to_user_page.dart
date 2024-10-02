import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/payments/widgets/send_payment/send_payment_to_user_view.dart';

class SendPaymentToUserPage extends StatelessWidget {
  const SendPaymentToUserPage({super.key});

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
        showBottomNavigationBar: false,
        actionAppBar: () {
          GoRouter.of(context).pushReplacementNamed(
            Routes.payments.name,
          );
        },
        pageAppBarTitle: l10n.sendPayment,
        children: [
          SizedBox(
            width: size.width * 0.90,
            height: size.height * 0.85,
            child: const SendPaymentToUserView(),
          ),
        ],
      ),
    );
  }
}
