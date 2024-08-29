import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/create_wallet/repositories/create_wallet_repository.dart';
import 'package:wallet_guru/infrastructure/create_wallet/data_sources/create_wallet_data_sources.dart';

class CreateWalletRepositoryImpl extends CreateWalletRepository {
  final CreateWalletDataSource createWalletDataSources;

  CreateWalletRepositoryImpl({required this.createWalletDataSources});

  @override
  Future<Either<InvalidData, ResponseModel>> createWallet(
      String addressName, String assetId) async {
    try {
      final ResponseModel response =
          await createWalletDataSources.createWallet(addressName, assetId);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> fetchWalletAssetId() async {
    try {
      final ResponseModel response =
          await createWalletDataSources.fetchWalletAssetId();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
