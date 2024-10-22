import 'package:flutter_bloc/flutter_bloc.dart';

import 'transaction_state.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';
import 'package:wallet_guru/domain/transactions/repositories/transaction_repository.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());
  final transactionRepository = Injector.resolve<TransactionRepository>();

    List<TransactionsModel> _processTransactions(List<TransactionsModel> transactions) {
    List<TransactionsModel> processedList = [];
    Map<String, TransactionsModel> providerTransactions = {};

    for (var transaction in transactions) {
      if (transaction.metadata.type == "PROVIDER") {
        // Agrupamos por receiverName para providers
        String providerKey = transaction.receiverName;
        
        if (providerTransactions.containsKey(providerKey)) {
          // Sumamos al proveedor existente
          var existingTransaction = providerTransactions[providerKey]!;
          double currentAmount = existingTransaction.receiveAmount?.value ?? 0;
          double newAmount = transaction.receiveAmount?.value ?? 0;

          providerTransactions[providerKey] = existingTransaction.copyWith(
            receiveAmount: Amount(
              typename: existingTransaction.receiveAmount?.typename ?? "",
              assetScale: existingTransaction.receiveAmount?.assetScale ?? 2,
              assetCode: existingTransaction.receiveAmount?.assetCode ?? "USD",
              value: currentAmount + newAmount,
            ),
          );
        } else {
          // Primera transacción del proveedor
          providerTransactions[providerKey] = transaction;
        }
      } else {
        // Para transacciones de usuarios, las agregamos directamente
        processedList.add(transaction);
      }
    }

    // Agregamos las transacciones de proveedores procesadas
    processedList.addAll(providerTransactions.values);

    // Ordenamos por fecha más reciente
    processedList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return processedList;
  }

  Future<void> loadTransactions({
    DateTime? startDate,
    DateTime? endDate,
    String? transactionType,
  }) async {
    emit(TransactionLoading());
    final result = await transactionRepository.getTransactions();
    result.fold(
      (exception) => emit(TransactionError(message: exception.toString())),
      (response) {
        final allTransactions = response.data!.transactions!;

        if (startDate != null && endDate != null && startDate!.isAfter(endDate!)) {
          final temp = startDate;
          startDate = endDate;
          endDate = temp;
        }

        final filteredTransactions = _filterTransactions(
          allTransactions,
          startDate,
          endDate,
          transactionType,
        );

        final processedTransactions = _processTransactions(filteredTransactions);

        emit(TransactionLoaded(
          payments: filteredTransactions,
          allPayments: allTransactions,
          processedPayments: processedTransactions,
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
