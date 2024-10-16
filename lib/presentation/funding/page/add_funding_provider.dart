import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/funding/widget/add_funding_providers_view.dart';

class AddFundsProvider extends StatelessWidget {
  const AddFundsProvider({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<SendPaymentCubit>(context).selectWalletUrlByTitle(title);

    return WalletGuruLayout(
      showSafeArea: true,
      showSimpleStyle: false,
      showLoggedUserAppBar: true,
      showBottomNavigationBar: false,
      actionAppBar: () {
        GoRouter.of(context).pushReplacementNamed(
          Routes.fundingScreen.name,
        );
      },
      pageAppBarTitle: title,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height * 0.80,
            child: AddFundingProviderView(
              title: title,
            ),
          ),
        ),
      ],
    );
  }
}
