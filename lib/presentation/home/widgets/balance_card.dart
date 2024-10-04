import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        color: AppColorSchema.of(context).tertiaryText,
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state.formStatusWallet is SubmissionSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBase(
                  text: l10n.homeBalance,
                  fontSize: size.width * 0.04,
                ),
                SizedBox(height: size.height * 0.01),
                TextBase(
                  text: toCurrencyString(state.balance.toString(),
                      leadingSymbol: '\$'),
                  fontSize: size.width * 0.1,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBase(
                          text: l10n.homeReservedFunds,
                          fontSize: size.width * 0.035,
                        ),
                        TextBase(
                          text: "\$0.00",
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBase(
                          text: l10n.homeAvailableFunds,
                          fontSize: size.width * 0.035,
                        ),
                        TextBase(
                          text: toCurrencyString(
                              state.availableFunds.toString(),
                              leadingSymbol: '\$'),
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else if (state.formStatusWallet is FormSubmitting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
