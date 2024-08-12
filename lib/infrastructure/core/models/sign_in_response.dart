class SignInResponseModel {
  final int statusCode;
  final String customCode;
  final SignInData data;

  SignInResponseModel({
    required this.statusCode,
    required this.customCode,
    required this.data,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      SignInResponseModel(
        statusCode: json["statusCode"],
        customCode: json["customCode"],
        data: SignInData.fromJson(json["data"]),
      );
}

class SignInData {
  final bool success;
  final String message;

  SignInData({
    required this.success,
    required this.message,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
        success: json["success"],
        message: json["message"],
      );
}
