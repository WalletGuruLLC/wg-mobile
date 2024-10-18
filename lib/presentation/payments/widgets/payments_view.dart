import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/funding/funding_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/input/gradient_button.dart';

class PaymentsView extends StatelessWidget {
  const PaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<FundingCubit>(context).resetCreateIncomingPaymentStatus();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          Assets.mainLogoWithLetter,
        ),
        SizedBox(
          height: size.height * 0.10,
        ),
        GradientButton(
          text: l10n.receivePayment,
          imageAsset: Assets.arrowDownIcon,
          onTap: () {
            GoRouter.of(context).pushReplacementNamed(
              Routes.receivePayment.name,
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        GradientButton(
          text: l10n.sendPayment,
          imageAsset: Assets.arrowUpIcon,
          onTap: () {
            GoRouter.of(context).pushReplacementNamed(
              Routes.selectWalletByForm.name,
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        GradientButton(
          text: l10n.addService,
          imageAsset: Assets.addIcon,
          onTap: () {
            GoRouter.of(context).pushReplacementNamed(
              Routes.addProvider.name,
            );
          },
        ),
      ],
    );
  }
}
