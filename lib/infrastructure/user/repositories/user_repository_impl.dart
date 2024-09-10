import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/user/repositories/user_repository.dart';
import 'package:wallet_guru/infrastructure/user/data_sources/user_data_source.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});

  @override
  Future<Either<InvalidData, ResponseModel>> getCurrentUserInformation() async {
    try {
      final ResponseModel response =
          await userDataSource.getCurrentUserInformation();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> updateUserInformation(
      Map<String, dynamic> changedUser, String userId) async {
    try {
      final ResponseModel response =
          await userDataSource.updateUserInformation(changedUser, userId);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> changePassword(
      String email, String currentPassword, String newPassword) async {
    try {
      final ResponseModel response = await userDataSource.changePassword(
          email, currentPassword, newPassword);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> lockAccount() async {
    try {
      final ResponseModel response = await userDataSource.lockAccount();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
