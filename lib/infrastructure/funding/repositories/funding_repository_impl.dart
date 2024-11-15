import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/entities/funding_entity.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/funding/funding_repository.dart';
import 'package:wallet_guru/infrastructure/funding/data_sources/funding_data_source.dart';

class FundingRepositoryImpl extends FundingRepository {
  final FundingDataSource fundingDataSource;

  FundingRepositoryImpl({required this.fundingDataSource});

  @override
  Future<Either<InvalidData, ResponseModel>> getListOfIncomingPayments() async {
    try {
      final ResponseModel response =
          await fundingDataSource.getListOfIncomingPayments();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> linkServerProvider(
      FundingEntity fundingEntity) async {
    try {
      final ResponseModel response =
          await fundingDataSource.linkServerProvider(fundingEntity);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> createIncomingPayment(
      FundingEntity fundingEntity) async {
    try {
      final ResponseModel response =
          await fundingDataSource.createIncomingPayment(fundingEntity);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> unlinkedServiceProvider(
      String sessionId) async {
    try {
      final ResponseModel response =
          await fundingDataSource.unlinkedServiceProvider(sessionId);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
