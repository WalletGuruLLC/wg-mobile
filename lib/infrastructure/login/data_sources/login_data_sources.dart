import 'dart:convert';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/infrastructure/core/models/sign_in_response.dart';
import 'package:wallet_guru/domain/core/models/error_response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/login/network/login_network.dart';

class LoginDataSource {
  Future<SignInResponseModel> signInUser(UserEntity singInUser) async {
    var response = await HttpDataSource.post(
      LoginNetwork.signIn,
      singInUser.toJson(),
    );

    if (response["statusCode"] == 200) {
      SignInResponseModel signInSignInResponseModel =
          SignInResponseModel.fromJson(response);
      return signInSignInResponseModel;
    } else {
      final result = jsonDecode(response.body);
      final errorModel = ErrorResponseModel.fromJson(result);
      throw InvalidData(errorModel.code, errorModel.message);
    }
  }
}
