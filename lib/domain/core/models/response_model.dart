class ResponseModel {
  final int statusCode;
  final String customCode;
  final String customMessage;
  final String customMessageEs;
  final Data? data;
  final Wallet? wallet;

  ResponseModel({
    required this.statusCode,
    required this.customCode,
    required this.customMessage,
    required this.customMessageEs,
    required this.data,
    required this.wallet,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        statusCode: json["statusCode"] ?? "",
        customCode: json["customCode"] ?? "",
        customMessage: json["customMessage"] ?? "",
        customMessageEs: json["customMessageEs"] ?? "",
        wallet: json["wallet"] != null
            ? (json["wallet"]["wallet"] != null
                ? Wallet.fromJson(json["wallet"]["wallet"])
                : Wallet.fromJson(json["wallet"]))
            : null,
        data: json["data"] != null
            ? Data.fromJson(json["data"])
            : Data.initialState(),
      );
}

class Data {
  final User? user;
  final Wallet? wallet;
  final List<RafikiAssets>? rafikiAssets;
  final String token;
  final bool success;
  final String message;

  Data({
    required this.user,
    required this.wallet,
    required this.rafikiAssets,
    required this.token,
    required this.success,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    User? user;
    if (json.containsKey("user") && json["user"] != null) {
      user = User.fromJson(json["user"]);
    } else if (!json.containsKey("user") && json.isNotEmpty) {
      user = User.fromJson(json);
    }

    return Data(
      user: user,
      wallet: json.containsKey("wallet") && json["wallet"] != null
          ? Wallet.fromJson(json["wallet"])
          : null,
      rafikiAssets:
          json.containsKey("rafikiAssets") && json["rafikiAssets"] != null
              ? List<RafikiAssets>.from(json["rafikiAssets"]
                  .map((rafikiAsset) => RafikiAssets.fromJson(rafikiAsset)))
              : null,
      token: json["token"] ?? '',
      success: json["success"] ?? false,
      message: json["message"] ?? '',
    );
  }

  factory Data.initialState() => Data(
        user: null,
        wallet: null,
        rafikiAssets: null,
        token: '',
        success: false,
        message: '',
      );

  bool hasUser() => user != null;

  bool hasWallet() => wallet != null;
}

class User {
  final bool privacyPolicy;
  final bool mfaEnabled;
  final bool termsConditions;
  final String otp;
  final bool sendSms;
  final int state;
  final String type;
  final String email;
  final String mfaType;
  final bool first;
  final String roleId;
  final bool sendEmails;
  final String picture;
  final String serviceProviderId;
  final String phone;
  final String address;
  final String city;
  final String country;
  final String zipCode;
  final String stateLocation;
  final String lastName;
  final String firstName;
  final String id;
  final bool active;
  final List<String> createDate;
  final List<String> accessLevel;

  User({
    required this.privacyPolicy,
    required this.mfaEnabled,
    required this.termsConditions,
    required this.otp,
    required this.sendSms,
    required this.state,
    required this.type,
    required this.email,
    required this.mfaType,
    required this.first,
    required this.roleId,
    required this.sendEmails,
    required this.picture,
    required this.serviceProviderId,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.lastName,
    required this.firstName,
    required this.id,
    required this.active,
    required this.phone,
    required this.address,
    required this.stateLocation,
    required this.createDate,
    required this.accessLevel,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        privacyPolicy: json["privacyPolicy"] ?? false,
        mfaEnabled: json["mfaEnabled"] ?? false,
        termsConditions: json["termsConditions"] ?? false,
        otp: json["otp"] ?? '',
        sendSms: json["sendSms"] ?? false,
        state: json["state"] ?? 0,
        type: json["type"] ?? '',
        email: json["email"] ?? '',
        mfaType: json["mfaType"] ?? '',
        first: json["first"] ?? false,
        roleId: json["roleId"] ?? '',
        sendEmails: json["sendEmails"] ?? false,
        picture: json["picture"] ?? '',
        serviceProviderId: json["serviceProviderId"] ?? '',
        city: json["city"] ?? '',
        country: json["country"] ?? '',
        zipCode: json["zipCode"] ?? '',
        lastName: json["lastName"] ?? '',
        firstName: json["firstName"] ?? '',
        id: json["id"] ?? '',
        active: json["active"] ?? false,
        phone: json["phone"] ?? '',
        address: json["address"] ?? '',
        stateLocation: json["stateLocation"] ?? '',
        createDate: json["createDate"] is List
            ? List<String>.from(json["createDate"])
            : [],
        accessLevel: json["accessLevel"] is List
            ? List<String>.from(json["accessLevel"])
            : [],
      );
  Map<String, dynamic> toJson() => {
        "PrivacyPolicy": privacyPolicy,
        "MfaEnabled": mfaEnabled,
        "TermsConditions": termsConditions,
        "Otp": otp,
        "SendSms": sendSms,
        "State": state,
        "type": type,
        "Email": email,
        "MfaType": mfaType,
        "First": first,
        "RoleId": roleId,
        "SendEmails": sendEmails,
        "Picture": picture,
        "ServiceProviderId": serviceProviderId,
        "city": city,
        "country": country,
        "zipCode": zipCode,
        "lastName": lastName,
        "firstName": firstName,
        "id": id,
        "Active": active,
        "Phone": phone,
        "Address": address,
        "StateLocation": stateLocation,
        "CreateDate": createDate,
        "AccessLevel": accessLevel,
      };

  factory User.initialState() => User(
        privacyPolicy: false,
        mfaEnabled: false,
        termsConditions: false,
        otp: '',
        sendSms: false,
        state: 0,
        type: '',
        email: '',
        mfaType: '',
        first: false,
        roleId: '',
        sendEmails: false,
        picture: '',
        serviceProviderId: '',
        city: '',
        country: '',
        zipCode: '',
        lastName: '',
        firstName: '',
        id: '',
        active: false,
        phone: '',
        address: '',
        stateLocation: '',
        createDate: [],
        accessLevel: [],
      );
}

class Wallet {
  final String id;
  final String name;
  final String walletType;
  final String? walletAddress;
  final bool active;
  final DateTime? createDate;
  final DateTime? updateDate;
  final String userId;
  final WalletAsset? walletAsset;
  final double balance;
  final double reserved;

  Wallet({
    required this.id,
    required this.name,
    required this.walletType,
    this.walletAddress,
    required this.active,
    this.createDate,
    this.updateDate,
    required this.userId,
    this.walletAsset,
    required this.balance,
    required this.reserved,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    final walletDb = json['walletDb'] ?? json;
    return Wallet(
      id: walletDb["id"] ?? '',
      name: walletDb["name"] ?? '',
      walletType: walletDb["walletType"] ?? '',
      walletAddress: walletDb["walletAddress"],
      active: walletDb["active"] ?? false,
      createDate: _parseDate(walletDb["createDate"]),
      updateDate: _parseDate(walletDb["updateDate"]),
      userId: walletDb["userId"] ?? '',
      walletAsset: json["walletAsset"] != null
          ? WalletAsset.fromJson(json["walletAsset"])
          : null,
      balance: json["balance"]?.toDouble() ?? 0.0,
      reserved: json["reserved"]?.toDouble() ?? 0.0,
    );
  }

  static DateTime? _parseDate(dynamic date) {
    if (date == null || (date is Map && date.isEmpty)) {
      return null;
    }
    return DateTime.parse(date);
  }
}

class WalletAsset {
  final String id;
  final String code;
  final String liquidity;
  final int scale;

  WalletAsset({
    required this.id,
    required this.code,
    required this.liquidity,
    required this.scale,
  });

  factory WalletAsset.fromJson(Map<String, dynamic> json) => WalletAsset(
        id: json["id"] ?? '',
        code: json["code"] ?? '',
        liquidity: json["liquidity"] ?? '',
        scale: json["scale"] ?? 0,
      );
}

class RafikiAssets {
  final String id;
  final String code;

  RafikiAssets({
    required this.id,
    required this.code,
  });

  factory RafikiAssets.fromJson(Map<String, dynamic> json) {
    print(json);
    return RafikiAssets(
      id: json["id"] ?? '',
      code: json["code"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
      };

  factory RafikiAssets.initialState() => RafikiAssets(
        id: '',
        code: '',
      );
}
