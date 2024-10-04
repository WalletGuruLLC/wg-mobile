import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/entities/send_payment_entity.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/send_payment/repositories/send_payment_repository.dart';
import 'package:wallet_guru/infrastructure/send_payment/data_sources/send_payment_data_sources.dart';

class SendPaymentRepositoryImpl extends SendPaymentRepository {
  final SendPaymentDataSource sendPaymentDataSources;

  SendPaymentRepositoryImpl({required this.sendPaymentDataSources});

  @override
  Future<Either<InvalidData, ResponseModel>> verifyWalletExistence(
      String walletAddress) async {
    try {
      final ResponseModel response =
          await sendPaymentDataSources.verifyWalletExistence(walletAddress);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> getWalletInformation() async {
    try {
      final ResponseModel response =
          await sendPaymentDataSources.getWalletInformation();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> createTransaction(
      WalletForPaymentEntity walletEntity,
      SendPaymentEntity sendPaymentEntity) async {
    try {
      final ResponseModel response = await sendPaymentDataSources
          .createTransaction(walletEntity, sendPaymentEntity);

      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> fetchWalletAsset() async {
    try {
      final ResponseModel response =
          await sendPaymentDataSources.fetchWalletAsset();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
