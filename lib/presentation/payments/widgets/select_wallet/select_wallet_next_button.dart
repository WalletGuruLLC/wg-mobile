import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';

class SelectWalletNextButton extends StatelessWidget {
  const SelectWalletNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SendPaymentCubit, SendPaymentState>(
      builder: (context, state) {
        final bool showButton = state.showNextButton;
        return showButton
            ? CustomButton(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                borderRadius: 12,
                color: AppColorSchema.of(context).buttonColor,
                border: Border.all(width: 0.75, color: Colors.transparent),
                text: l10n.next,
                height: 56,
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    Routes.sendPaymentToUser.name,
                  );
                },
              )
            : const SizedBox();
      },
    );
  }
}
