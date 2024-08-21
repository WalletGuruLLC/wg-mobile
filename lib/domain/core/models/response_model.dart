class ResponseModel {
  final int statusCode;
  final String customCode;
  final String customMessage;
  final String customMessageEs;
  final Data? data;

  ResponseModel({
    required this.statusCode,
    required this.customCode,
    required this.customMessage,
    required this.customMessageEs,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        statusCode: json["statusCode"],
        customCode: json["customCode"],
        customMessage: json["customMessage"],
        customMessageEs: json["customMessageEs"],
        data: json["data"] != null
            ? Data.fromJson(json["data"])
            : Data.initialState(),
      );
}

class Data {
  final User? user;
  final String token;
  final bool success;
  final String message;

  Data({
    required this.user,
    required this.token,
    required this.success,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] != null
            ? User.fromJson(json["user"])
            : User.initialState(),
        token: json["token"] ?? '',
        success: json["success"] ?? false,
        message: json["message"] ?? '',
      );

  factory Data.initialState() => Data(
        user: User.initialState(),
        token: '',
        success: false,
        message: '',
      );
}

class User {
  final bool privacyPolicy;
  final bool mfaEnabled;
  final DateTime createDate;
  final bool termsConditions;
  final String otp;
  final bool sendSms;
  final int state;
  final String email;
  final String mfaType;
  final bool first;
  final String roleId;
  final bool sendEmails;
  final DateTime updateDate;
  final String picture;
  final String serviceProviderId;
  final bool active;
  final String type;

  User({
    required this.privacyPolicy,
    required this.mfaEnabled,
    required this.createDate,
    required this.termsConditions,
    required this.otp,
    required this.sendSms,
    required this.state,
    required this.email,
    required this.mfaType,
    required this.first,
    required this.roleId,
    required this.sendEmails,
    required this.updateDate,
    required this.picture,
    required this.serviceProviderId,
    required this.active,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        privacyPolicy: json["PrivacyPolicy"],
        mfaEnabled: json["MfaEnabled"],
        createDate: DateTime.parse(json["CreateDate"]),
        termsConditions: json["TermsConditions"],
        otp: json["Otp"],
        sendSms: json["SendSms"],
        state: json["State"],
        email: json["Email"],
        mfaType: json["MfaType"],
        first: json["First"],
        roleId: json["RoleId"],
        sendEmails: json["SendEmails"],
        updateDate: DateTime.parse(json["UpdateDate"]),
        picture: json["Picture"],
        serviceProviderId: json["ServiceProviderId"],
        active: json["Active"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "PrivacyPolicy": privacyPolicy,
        "MfaEnabled": mfaEnabled,
        "CreateDate": createDate.toIso8601String(),
        "TermsConditions": termsConditions,
        "Otp": otp,
        "SendSms": sendSms,
        "State": state,
        "Email": email,
        "MfaType": mfaType,
        "First": first,
        "RoleId": roleId,
        "SendEmails": sendEmails,
        "UpdateDate": updateDate.toIso8601String(),
        "Picture": picture,
        "ServiceProviderId": serviceProviderId,
        "Active": active,
        "type": type,
      };

  factory User.initialState() => User(
        privacyPolicy: false,
        mfaEnabled: false,
        createDate: DateTime.now(),
        termsConditions: false,
        otp: '',
        sendSms: false,
        state: 0,
        email: '',
        mfaType: '',
        first: false,
        roleId: '',
        sendEmails: false,
        updateDate: DateTime.now(),
        picture: '',
        serviceProviderId: '',
        active: false,
        type: '',
      );
}
