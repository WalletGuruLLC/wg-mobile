import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/infrastructure/core/models/sign_in_response.dart';

abstract class LoginRepository {
  Future<Either<InvalidData, SignInResponseModel>> signInUser(
      UserEntity signInUser);
}
