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
  final CreateWallet? createWallet; // Cambiado a nullable
  final String token;
  final bool success;
  final String message;

  Data({
    this.user,
    this.createWallet,
    required this.token,
    required this.success,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json.containsKey("user") && json["user"] != null
            ? User.fromJson(json["user"])
            : null,
        createWallet:
            json.containsKey("createWallet") && json["createWallet"] != null
                ? CreateWallet.fromJson(json["createWallet"])
                : null,
        token: json["token"] ?? '',
        success: json["success"] ?? false,
        message: json["message"] ?? '',
      );

  factory Data.initialState() => Data(
        user: null,
        createWallet: null,
        token: '',
        success: false,
        message: '',
      );

  bool hasUser() => user != null;

  bool hasCreateWallet() => createWallet != null;
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
        privacyPolicy: json["PrivacyPolicy"] ?? false,
        mfaEnabled: json["MfaEnabled"] ?? false,
        createDate: DateTime.parse(json["CreateDate"]),
        termsConditions: json["TermsConditions"] ?? false,
        otp: json["Otp"] ?? '',
        sendSms: json["SendSms"] ?? false,
        state: json["State"] ?? 0,
        email: json["Email"] ?? '',
        mfaType: json["MfaType"] ?? '',
        first: json["First"] ?? false,
        roleId: json["RoleId"] ?? '',
        sendEmails: json["SendEmails"] ?? false,
        updateDate: DateTime.parse(json["UpdateDate"]),
        picture: json["Picture"] ?? '',
        serviceProviderId: json["ServiceProviderId"] ?? '',
        active: json["Active"] ?? false,
        type: json["type"] ?? '',
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

class CreateWallet {
  final String id;
  final String name;
  final String walletType;
  final String walletAddress;
  final bool active;

  CreateWallet({
    required this.id,
    required this.name,
    required this.walletType,
    required this.walletAddress,
    required this.active,
  });

  factory CreateWallet.fromJson(Map<String, dynamic> json) => CreateWallet(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        walletType: json["walletType"] ?? '',
        walletAddress: json["walletAddress"] ?? '',
        active: json["active"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "walletType": walletType,
        "walletAddress": walletAddress,
        "active": active,
      };

  factory CreateWallet.initialState() => CreateWallet(
        id: '',
        name: '',
        walletType: '',
        walletAddress: '',
        active: false,
      );
}
