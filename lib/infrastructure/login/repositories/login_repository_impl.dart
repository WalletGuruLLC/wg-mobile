import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/login/repositories/login_repository.dart';
import 'package:wallet_guru/infrastructure/login/data_sources/login_data_sources.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDataSource loginDataSource;

  LoginRepositoryImpl({required this.loginDataSource});

  @override
  Future<Either<InvalidData, ResponseModel>> signInUser(
      String email, String password) async {
    try {
      final ResponseModel response =
          await loginDataSource.signInUser(email, password);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> verifyEmailOtp(
      String email, String otp) async {
    try {
      final ResponseModel response =
          await loginDataSource.verifyEmailOtp(email, otp);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> resendOtp(String email) async {
    try {
      final ResponseModel response = await loginDataSource.resendOtp(email);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }

  @override
  Future<Either<InvalidData, ResponseModel>> logOut() async {
    try {
      final ResponseModel response = await loginDataSource.logOut();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
