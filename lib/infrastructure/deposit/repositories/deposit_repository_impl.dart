import 'package:either_dart/either.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/deposit/repositories/deposit_repository.dart';
import 'package:wallet_guru/infrastructure/deposit/data_sources/deposit_data_sources.dart';

class DepositRepositoryImpl extends DepositRepository {
  final DepositDataSource depositDataSource;

  DepositRepositoryImpl({required this.depositDataSource});

  @override
  Future<Either<InvalidData, ResponseModel>> createDepositWallet(
      String walletAddressId, int amount) async {
    try {
      final ResponseModel response =
          await depositDataSource.createDepositWallet(walletAddressId, amount);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
