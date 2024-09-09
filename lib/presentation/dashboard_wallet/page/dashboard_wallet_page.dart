import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
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
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.setUser(loginCubit.state.user!);
    // userCubit.setUserId(loginCubit.state.userId);
    // userCubit.emitGetUserInformation();
    // loginCubit.initialStatus();
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
          child: GestureDetector(
            onTap: () {
              GoRouter.of(context).pushReplacementNamed(
                Routes.myProfile.name,
              );
            },
            child: Image.asset(
              Assets.walletDashboard,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ],
    );
  }
}
