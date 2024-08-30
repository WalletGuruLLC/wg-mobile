import 'package:flutter/widgets.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';

class DashboardWalletPage extends StatelessWidget {
  const DashboardWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WalletGuruLayout(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      showBackButton: false,
      showBottomNavigationBar: true,
      showAppBar: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Image.asset(
            Assets.walletDashboard,
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}
