import 'package:flutter_bloc/flutter_bloc.dart';

import 'transaction_state.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';
import 'package:wallet_guru/domain/transactions/repositories/transaction_repository.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());
  final transactionRepository = Injector.resolve<TransactionRepository>();

  Future<void> loadTransactions(
      {DateTime? startDate, DateTime? endDate, String? transactionType}) async {
    emit(TransactionLoading());
    final result = await transactionRepository.getTransactions();
    result.fold(
      (exception) => emit(TransactionError(message: exception.toString())),
      (response) {
        final allTransactions = response.data!.transactions!;

        if (startDate != null &&
            endDate != null &&
            startDate!.isAfter(endDate!)) {
          final temp = startDate;
          startDate = endDate;
          endDate = temp;
        }

        final filteredTransactions = _filterTransactions(
            allTransactions, startDate, endDate, transactionType);
        emit(TransactionLoaded(
          payments: filteredTransactions,
          allPayments: allTransactions,
          startDate: startDate,
          endDate: endDate,
          transactionType: transactionType,
        ));
      },
    );
  }

  List<TransactionsModel> _filterTransactions(
    List<TransactionsModel> transactions,
    DateTime? startDate,
    DateTime? endDate,
    String? transactionType,
  ) {
    if (startDate == endDate) {
      startDate = null;
      endDate = null;
    }
    return transactions.where((t) {
      final isInDateRange =
          (startDate == null || !t.createdAt.isBefore(startDate)) &&
              (endDate == null || !t.createdAt.isAfter(endDate));
      final matchesType = transactionType == null ||
          transactionType == 'All' ||
          (transactionType == 'Credits' && t.type == 'IncomingPayment') ||
          (transactionType == 'Debits' && t.type == 'OutgoingPayment');
      return isInDateRange && matchesType;
    }).toList();
  }
}
