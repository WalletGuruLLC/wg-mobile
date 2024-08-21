import 'dart:convert';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/login/network/login_network.dart';

class LoginDataSource {
  Future<ResponseModel> signInUser(String email, String password) async {
    var response = await HttpDataSource.post(
      LoginNetwork.signIn,
      {
        "email": email,
        "password": password,
      },
    );

    if (response["statusCode"] == 200) {
      ResponseModel signInSignInResponseModel =
          ResponseModel.fromJson(response);
      return signInSignInResponseModel;
    } else {
      final result = jsonDecode(response.body);
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessageEs);
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

    if (response["statusCode"] == 200) {
      ResponseModel userAuthenticationResponse =
          ResponseModel.fromJson(response);
      return userAuthenticationResponse;
    } else {
      final result = jsonDecode(response.body);
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessageEs);
    }
  }
}
