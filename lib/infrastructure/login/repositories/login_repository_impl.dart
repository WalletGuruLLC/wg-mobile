import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/login/repositories/login_repository.dart';
import 'package:wallet_guru/infrastructure/core/models/sign_in_response.dart';
import 'package:wallet_guru/infrastructure/login/data_sources/login_data_sources.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDataSource loginDataSource;

  LoginRepositoryImpl({required this.loginDataSource});

  @override
  Future<Either<InvalidData, SignInResponseModel>> signInUser(
      UserEntity singInUser) async {
    try {
      final SignInResponseModel response =
          await loginDataSource.signInUser(singInUser);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
