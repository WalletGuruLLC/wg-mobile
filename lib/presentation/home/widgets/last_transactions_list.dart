import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/application/transactions/transaction_cubit.dart';
import 'package:wallet_guru/application/transactions/transaction_state.dart';
import 'package:wallet_guru/presentation/home/widgets/transaction_item.dart';
import 'package:wallet_guru/presentation/home/widgets/transaction_skeleton.dart';

class LastTransactionsList extends StatelessWidget {
  const LastTransactionsList({super.key});

  String _getDisplayTitle(TransactionsModel payment) {
    if (payment.type == 'OutgoingPayment') {
      if (payment.metadata.type == "PROVIDER") {
        // Para providers, concatenamos el receiverName y contentName
        return "${payment.receiverName}${payment.metadata.contentName.isNotEmpty ? ' - ${payment.metadata.contentName}' : ''}";
      }
      return payment.receiverName;
    }
    return payment.senderName;
  }

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
                      title: _getDisplayTitle(payment),
                      transactionType: payment.type,
                      amount: payment.incomingAmount != null
                          ? (payment.incomingAmount!.value).toString()
                          : (payment.receiveAmount!.value).toString(),
                      isProvider: payment.metadata.type == "PROVIDER",
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
