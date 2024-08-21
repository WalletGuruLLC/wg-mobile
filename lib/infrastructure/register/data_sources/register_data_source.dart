import 'dart:convert';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/models/user_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/register/network/register_network.dart';

class RegisterDataSource {
  Future<UserModel> creationUser(String email, String password) async {
    var response = await HttpDataSource.post(
      RegisterNetwork.registerUser,
      {
        "email": email,
        "passwordHash": password,
        "type": "WALLET",
      },
    );

    if (response.statusCode == 200) {
      UserModel registerModel = UserModel.fromJson(response);
      return registerModel;
    } else {
      final result = jsonDecode(response.body);
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage);
    }
  }
}
