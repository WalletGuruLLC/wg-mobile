import 'package:wallet_guru/infrastructure/core/models/user_model.dart';

class SignInResponseModel {
  final int statusCode;
  final String message;
  final SignInData data;

  SignInResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      SignInResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: SignInData.fromJson(json["data"]),
      );
}

class SignInData {
  final String token;
  final UserModel user;

  SignInData({
    required this.token,
    required this.user,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
        token: json["token"],
        user: UserModel.fromJson(json["user"]),
      );
}
