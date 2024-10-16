import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';

import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/funding/page/add_funding_page.dart';

class CardFundingWidget extends StatelessWidget {
  const CardFundingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state.formStatusWallet is SubmissionFailed) {
            GoRouter.of(context).pushReplacementNamed(
              Routes.errorScreen.name,
            );
          }
        },
        builder: (context, state) {
          if (state.formStatusWallet is SubmissionSuccess) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBase(
                  text:
                      "${toCurrencyString(state.availableFunds.toString(), leadingSymbol: '\$')} USD",
                  fontSize: size.width * 0.07,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddFundingPage()),
                  ),
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
