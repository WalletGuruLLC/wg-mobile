import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/transactions/repositories/transaction_repository.dart';
import 'package:wallet_guru/infrastructure/transactions/data_sources/transaction_data_source.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionDataSource transactionDataSource;

  TransactionRepositoryImpl({
    required this.transactionDataSource,
  });

  @override
  Future<Either<InvalidData, ResponseModel>> getTransactions() async {
    try {
      final ResponseModel response =
          await transactionDataSource.fetchTransactions();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
