import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';

abstract class UserRepository {
  Future<Either<InvalidData, ResponseModel>> getCurrentUserInformation(
    String userId,
  );
  Future<Either<InvalidData, ResponseModel>> updateUserInformation(
      UserEntity user);
}
