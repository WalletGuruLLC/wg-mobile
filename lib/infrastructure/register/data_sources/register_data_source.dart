import 'dart:convert';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/infrastructure/core/models/user_model.dart';
import 'package:wallet_guru/domain/core/models/error_response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/register/network/register_%20network.dart';

class RegisterDataSource {
  Future<UserModel> creationUser(UserEntity createUser) async {
    var response = await HttpDataSource.post(
      RegisterNetwork.registerUser,
      createUser.toJson(),
    );

    if (response["statusCode"] == 200) {
      UserModel registerModel = UserModel.fromJson(response);
      return registerModel;
    } else {
      final result = jsonDecode(response.body);
      final errorModel = ErrorResponseModel.fromJson(result);
      throw InvalidData(errorModel.code, errorModel.message);
    }
  }
}
