import 'package:equatable/equatable.dart';
import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TransactionsModel> payments;
  final List<TransactionsModel> allPayments;
  final List<TransactionsModel>
      processedPayments; // Nueva lista para transacciones procesadas

  final DateTime? startDate;
  final DateTime? endDate;
  final String? transactionType;

  const TransactionLoaded({
    required this.payments,
    required this.allPayments,
    required this.processedPayments,
    this.startDate,
    this.endDate,
    this.transactionType,
  });

  @override
  List<Object?> get props => [
        payments,
        allPayments,
        processedPayments,
        startDate,
        endDate,
        transactionType,
      ];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object?> get props => [message];
}
