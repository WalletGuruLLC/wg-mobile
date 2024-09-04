import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';

class DashboardWalletPage extends StatefulWidget {
  const DashboardWalletPage({super.key});

  @override
  State<DashboardWalletPage> createState() => _DashboardWalletPageState();
}

class _DashboardWalletPageState extends State<DashboardWalletPage> {
  @override
  void initState() {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.initialStatus();
    super.initState();
  }

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
