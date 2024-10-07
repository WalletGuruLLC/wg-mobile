// lib/cubits/transaction_state.dart

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

  const TransactionLoaded({required this.payments});

  @override
  List<Object?> get props => [payments];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object?> get props => [message];
}
