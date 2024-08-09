class ErrorResponseModel {
  ErrorResponseModel({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        code: json["code"] ?? '',
        message: json["message"] ?? '',
      );

  factory ErrorResponseModel.empty() => ErrorResponseModel(
        code: '123',
        message: 'error message',
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
