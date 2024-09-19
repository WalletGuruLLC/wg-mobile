import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/receive_payment/repositories/receive_payment_repository.dart';
import 'package:wallet_guru/infrastructure/receive_payment/data_sources/receive_payment_data_sources.dart';

class ReceivePaymentRepositoryImpl extends ReceivePaymentRepository {
  final ReceivePaymentDataSource receivePaymentDataSources;

  ReceivePaymentRepositoryImpl({required this.receivePaymentDataSources});

  @override
  Future<Either<InvalidData, ResponseModel>> verifyWalletExistence(
      String walletAddress) async {
    try {
      final ResponseModel response =
          await receivePaymentDataSources.verifyWalletExistence(walletAddress);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
