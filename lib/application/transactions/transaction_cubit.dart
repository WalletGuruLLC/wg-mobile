import 'package:flutter_bloc/flutter_bloc.dart';

import 'transaction_state.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';
import 'package:wallet_guru/domain/transactions/repositories/transaction_repository.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());
  final transactionRepository = Injector.resolve<TransactionRepository>();

  List<TransactionsModel> _processTransactions(
      List<TransactionsModel> transactions) {
    List<TransactionsModel> processedList = [];
    Map<String, TransactionsModel> providerTransactions = {};

    for (var transaction in transactions) {
      if (transaction.metadata.type == "PROVIDER") {
        // Agrupamos por receiverName y activityId para providers
        String providerKey =
            "${transaction.receiverName}_${transaction.metadata.activityId}";

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
    try {
      final result = await transactionRepository.getTransactions();
      result.fold(
        (exception) => emit(TransactionError(message: exception.toString())),
        (response) {
          final allTransactions = response.data!.transactions!;

          // Normalizamos las fechas si es necesario
          if (startDate != null &&
              endDate != null &&
              startDate!.isAfter(endDate!)) {
            final temp = startDate;
            startDate = endDate;
            endDate = temp;
          }

          // Primero filtramos
          final filteredTransactions = _filterTransactions(
            allTransactions,
            startDate,
            endDate,
            transactionType,
          );

          // Luego procesamos y agrupamos
          final processedTransactions =
              _processTransactions(filteredTransactions);

          emit(TransactionLoaded(
            payments: allTransactions,
            allPayments: allTransactions,
            processedPayments: processedTransactions,
            startDate: startDate,
            endDate: endDate,
            transactionType: transactionType,
          ));
        },
      );
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
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
      final date =
          DateTime(t.createdAt.year, t.createdAt.month, t.createdAt.day);
      final start = startDate != null
          ? DateTime(startDate.year, startDate.month, startDate.day)
          : null;
      final end = endDate != null
          ? DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59)
          : null;

      final isInDateRange = (start == null || !date.isBefore(start)) &&
          (end == null || !date.isAfter(end));
      final matchesType = transactionType == null ||
          transactionType == 'All' ||
          (transactionType == 'Credits' && t.type == 'IncomingPayment') ||
          (transactionType == 'Debits' && t.type == 'OutgoingPayment');

      return isInDateRange && matchesType;
    }).toList();
  }
}
