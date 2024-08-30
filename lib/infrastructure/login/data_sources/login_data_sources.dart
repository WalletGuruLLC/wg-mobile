import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/login/network/login_network.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';

class LoginDataSource {
  Future<ResponseModel> signInUser(String email, String password) async {
    var response = await HttpDataSource.post(
      LoginNetwork.signIn,
      {
        "email": email,
        "password": password,
      },
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel signInSignInResponseModel = ResponseModel.fromJson(result);
      return signInSignInResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }

  Future<ResponseModel> verifyEmailOtp(String email, String otp) async {
    var response = await HttpDataSource.post(
      LoginNetwork.verifyEmailOtp,
      {
        "email": email,
        "otp": otp,
      },
    );
    final result = jsonDecode(response.body);
    final storage = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      ResponseModel userAuthenticationResponse = ResponseModel.fromJson(result);
      storage.setString('Basic', userAuthenticationResponse.data!.token);

      return userAuthenticationResponse;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }
}
