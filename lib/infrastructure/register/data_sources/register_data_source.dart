import 'dart:convert';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/register/network/register_network.dart';
import 'package:wallet_guru/presentation/core/utils/global_error_translations.dart';

class RegisterDataSource {
  Future<ResponseModel> creationUser(String email, String password) async {
    var response = await HttpDataSource.post(
      RegisterNetwork.registerUser,
      {
        "email": email,
        "passwordHash": password,
        "type": "WALLET",
        "termsConditions": true,
        "privacyPolicy": true,
      },
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 201) {
      ResponseModel registerModel = ResponseModel.fromJson(result);
      return registerModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
    }
  }
}
