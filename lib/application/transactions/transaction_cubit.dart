import 'package:flutter_bloc/flutter_bloc.dart';

import 'transaction_state.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/transactions/repositories/transaction_repository.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());
  final transactionRepository = Injector.resolve<TransactionRepository>();

  Future<void> loadTransactions() async {
    emit(TransactionLoading());
    final result = await transactionRepository.getTransactions();
    result.fold(
      (exception) => emit(TransactionError(message: exception.toString())),
      (response) {
        final payments =
            response.data!.transactions!;
        emit(TransactionLoaded(payments: payments));
      },
    );
  }
}
