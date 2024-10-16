import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/core/entities/send_payment_entity.dart';
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

  @override
  Future<Either<InvalidData, ResponseModel>> getExchangeRate(
      String currency) async {
    try {
      final ResponseModel response =
          await sendPaymentDataSources.getExchangeRate(currency);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> getListIncomingPayment() async {
    try {
      final ResponseModel response =
          await sendPaymentDataSources.getListIncomingPayment();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> getListCancelIncoming(
      List<String> incomingIds) async {
    Either<InvalidData, ResponseModel>? lastResult;
    await Future.wait(incomingIds.map((id) async {
      final result = await _processSingleCancelIncoming(id);
      lastResult = result;
    }));

    return lastResult ??
        Left(InvalidData('No se procesaron transacciones',
            'No transactions were processed', ''));
  }

  Future<Either<InvalidData, ResponseModel>> _processSingleCancelIncoming(
      String id) async {
    try {
      final ResponseModel response =
          await sendPaymentDataSources.getCancelIncoming(id);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
