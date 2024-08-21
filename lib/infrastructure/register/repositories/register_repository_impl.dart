import 'package:either_dart/either.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/register/repositories/register_repository.dart';
import 'package:wallet_guru/infrastructure/register/data_sources/register_data_source.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterDataSource registerDataSource;

  RegisterRepositoryImpl({required this.registerDataSource});

  @override
  Future<Either<InvalidData, UserEntity>> creationUser(
      String email, String password) async {
    try {
      final UserEntity response =
          await registerDataSource.creationUser(email, password);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
