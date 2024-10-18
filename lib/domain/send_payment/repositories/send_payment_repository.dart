import 'package:either_dart/either.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/core/entities/send_payment_entity.dart';

abstract class SendPaymentRepository {
  Future<Either<InvalidData, ResponseModel>> verifyWalletExistence(
      String walletAddress);
  Future<Either<InvalidData, ResponseModel>> getWalletInformation();
  Future createTransaction(
      WalletForPaymentEntity walletEntity, SendPaymentEntity sendPaymentEntity);
  Future<Either<InvalidData, ResponseModel>> fetchWalletAsset();
  Future<Either<InvalidData, ResponseModel>> getExchangeRate(String currency);
  Future<Either<InvalidData, ResponseModel>> getListIncomingPayment();
  Future<Either<InvalidData, ResponseModel>> getListCancelIncoming(
      List<String> incomingIds);
  Future<Either<InvalidData, ResponseModel>> getLinkedProviders();
}
