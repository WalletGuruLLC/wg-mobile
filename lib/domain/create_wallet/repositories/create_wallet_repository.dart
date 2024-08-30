import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';

abstract class CreateWalletRepository {
  Future<Either<InvalidData, ResponseModel>> createWallet(
      String addressName, String assetId);

  Future<Either<InvalidData, ResponseModel>> fetchWalletAssetId();
}
