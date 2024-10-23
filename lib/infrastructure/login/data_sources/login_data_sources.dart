import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/login/network/login_network.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/presentation/core/utils/global_error_translations.dart';

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
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
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
      storage.setString('email', userAuthenticationResponse.data!.user!.email);
      storage.setBool(
          'firstFunding', userAuthenticationResponse.data!.user!.firstFunding);
      await refreshToken();
      return userAuthenticationResponse;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
    }
  }

  Future<ResponseModel> resendOtp(String email) async {
    var response = await HttpDataSource.post(
      LoginNetwork.resendOtp,
      {
        "email": email,
      },
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 201) {
      ResponseModel resendOtpResponseModel = ResponseModel.fromJson(result);
      return resendOtpResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
    }
  }

  Future<ResponseModel> logOut() async {
    var response = await HttpDataSource.post(
      LoginNetwork.logOut,
      {},
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel logOutResponseModel = ResponseModel.fromJson(result);
      HttpDataSource.cleanHeardes();
      return logOutResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
    }
  }

  Future<ResponseModel> forgotPassword(String email) async {
    var response = await HttpDataSource.post(
      LoginNetwork.forgotPassword,
      {
        "email": email,
      },
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel forgotPasswordResponseModel =
          ResponseModel.fromJson(result);
      return forgotPasswordResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
    }
  }

  Future<ResponseModel> changePassword(
      String email, String otp, String newPassword) async {
    var response = await HttpDataSource.post(
      LoginNetwork.changePassword,
      {
        "email": email,
        "confirmationCode": otp,
        "newPassword": newPassword,
      },
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel changePasswordResponseModel =
          ResponseModel.fromJson(result);
      return changePasswordResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
    }
  }

  Future<ResponseModel> refreshToken() async {
    final storage = await SharedPreferences.getInstance();
    final String? userEmail = storage.getString('email');
    final String? basic = storage.getString('Basic');
    var response = await HttpDataSource.post(
      LoginNetwork.refreshToken,
      {
        "email": userEmail,
        "token": basic,
      },
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel signUpResponseModel = ResponseModel.fromJson(result);
      return signUpResponseModel;
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
