import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/register/models/register_model.dart';

abstract class RegisterRepository {
  Future<Either<InvalidData, RegisterModel>> creationUser();
}
