import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/entities/funding_entity.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';

abstract class FundingRepository {
  Future<Either<InvalidData, ResponseModel>> getListOfIncomingPayments();
  Future<Either<InvalidData, ResponseModel>> linkServerProvider(
      FundingEntity fundingEntity);
  Future<Either<InvalidData, ResponseModel>> createIncomingPayment(
      FundingEntity fundingEntity);
  Future<Either<InvalidData, ResponseModel>> unlinkedServiceProvider(
      String sessionId);
}
