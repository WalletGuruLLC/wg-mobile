import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/application/transactions/transaction_cubit.dart';
import 'package:wallet_guru/application/transactions/transaction_state.dart';
import 'package:wallet_guru/presentation/home/widgets/transaction_item.dart';
import 'package:wallet_guru/presentation/home/widgets/transaction_skeleton.dart';

class LastTransactionsList extends StatelessWidget {
  const LastTransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBase(
          text: l10n.homeLastTransactions,
          fontSize: size.width * 0.04,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: size.height * 0.02),
        BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(4, (index) => const TransactionSkeleton()),
                ],
              );
            } else if (state is TransactionLoaded) {
              final transactions = state.processedPayments.take(4).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...transactions.map((payment) {
                    return TransactionItem(
                      title: payment.type == 'OutgoingPayment'
                          ? payment.receiverName
                          : payment.senderName,
                      transactionType: payment.type,
                      amount: payment.incomingAmount != null
                          ? (payment.incomingAmount!.value).toString()
                          : (payment.receiveAmount!.value).toString(),
                    );
                  }),
                  SizedBox(height: size.height * 0.01),
                  Visibility(
                    visible: transactions.isNotEmpty,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => GoRouter.of(context)
                            .go(Routes.transactionChart.path),
                        child: TextBase(
                          text: l10n.homeSeeMore,
                          color: Colors.blue,
                          fontSize: size.width * 0.035,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
