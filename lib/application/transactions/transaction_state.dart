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
  final DateTime? startDate;
  final DateTime? endDate;
  final String? transactionType;

  const TransactionLoaded({
    required this.payments,
    required this.allPayments,
    this.startDate,
    this.endDate,
    this.transactionType,
  });

  @override
  List<Object?> get props =>
      [payments, allPayments, startDate, endDate, transactionType];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object?> get props => [message];
}
