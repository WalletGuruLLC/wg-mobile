import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/application/deposit/deposit_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/funding/widget/funding_screen_view.dart';

class FundingScreenPage extends StatefulWidget {
  const FundingScreenPage({super.key});

  @override
  State<FundingScreenPage> createState() => _FundingScreenPageState();
}

class _FundingScreenPageState extends State<FundingScreenPage> {
  @override
  void initState() {
    super.initState();
    String walletAddress =
        BlocProvider.of<UserCubit>(context).state.wallet!.walletDb.rafikiId;
    BlocProvider.of<DepositCubit>(context).emitwalletId(walletAddress);
  }

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
            Routes.home.name,
          );
        },
        pageAppBarTitle: l10n.fundingTitelPage,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SizedBox(
              width: size.width * 0.90,
              height: size.height * 0.80,
              child: const FundingScreenView(),
            ),
          ),
        ],
      ),
    );
  }
}
