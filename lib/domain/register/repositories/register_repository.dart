import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';

abstract class RegisterRepository {
  Future<Either<InvalidData, UserEntity>> creationUser(UserEntity createUser);
}
