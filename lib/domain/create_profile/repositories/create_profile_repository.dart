import 'dart:io';

import 'package:either_dart/either.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';

abstract class CreateProfileRepository {
  Future<Either<InvalidData, ResponseModel>>
      updateUser<T extends BaseProfileEntity>(T entity);
  Future<Either<InvalidData, ResponseModel>> updateUserPicture(
      File picture, String userId);
  Future<Either<InvalidData, ResponseModel>> generateSumSubAccessToken(
      String userId);
}
