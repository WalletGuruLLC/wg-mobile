import 'dart:convert';

import 'package:wallet_guru/domain/core/models/error_response_model.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/register/models/register_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';

class RegisterDataSource {
  Future<RegisterModel> creationUser(String code) async {
    var response = await HttpDataSource.post(
        "", {"project": "ChelseaProject", "code": code});

    if (response["statusCode"] == 200) {
      RegisterModel registerModel = RegisterModel.fromJson(response);
      return registerModel;
    } else {
      final result = jsonDecode(response.body);
      final errorModel = ErrorResponseModel.fromJson(result);
      throw InvalidData(errorModel.code, errorModel.message);
    }
  }
}
