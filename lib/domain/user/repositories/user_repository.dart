import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';

abstract class UserRepository {
  Future<Either<InvalidData, ResponseModel>> getCurrentUserInformation();
  Future<Either<InvalidData, ResponseModel>> updateUserInformation(
      Map<String, dynamic> changedUser, String userId);

  Future<Either<InvalidData, ResponseModel>> changePassword(
      String email, String currentPassword, String newPassword);
}
