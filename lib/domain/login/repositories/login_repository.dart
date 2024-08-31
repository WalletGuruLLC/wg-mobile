import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';

abstract class LoginRepository {
  Future<Either<InvalidData, ResponseModel>> signInUser(
      String email, String password);

  Future<Either<InvalidData, ResponseModel>> verifyEmailOtp(
      String email, String otp);

  Future<Either<InvalidData, ResponseModel>> resendOtp(String email);
}
