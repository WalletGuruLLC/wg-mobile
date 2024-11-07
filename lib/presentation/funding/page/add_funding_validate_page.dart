import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/application/funding/funding_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/funding/widget/add_funding_validate_view.dart';

class AddFundingValidatePage extends StatelessWidget {
  const AddFundingValidatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String providerName = BlocProvider.of<FundingCubit>(context)
        .state
        .fundingEntity!
        .serviceProviderName;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final navigator = Navigator.of(context);
        navigator.pop();
      },
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
        pageAppBarTitle: providerName,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SizedBox(
              width: size.width * 0.90,
              height: size.height * 0.80,
              child: const AddFundingValidateView(),
            ),
          ),
        ],
      ),
    );
  }
}
