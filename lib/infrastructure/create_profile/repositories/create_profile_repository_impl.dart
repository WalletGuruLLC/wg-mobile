import 'package:either_dart/either.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';
import 'package:wallet_guru/domain/create_profile/repositories/create_profile_repository.dart';
import 'package:wallet_guru/infrastructure/create_profile/data_sources/create_profile_data_source.dart';

class CreateProfileRepositoryImpl extends CreateProfileRepository {
  final CreateProfileDataSource registerDataSource;

  CreateProfileRepositoryImpl({required this.registerDataSource});

    @override
  Future<Either<InvalidData, ResponseModel>> updateUser<T extends BaseProfileEntity>(T entity) async {
    try {
      final ResponseModel response = await registerDataSource.updateUser(entity);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
