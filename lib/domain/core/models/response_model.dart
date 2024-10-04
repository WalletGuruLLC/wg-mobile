import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';

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
  final TransactionsModel? transactionsModel;
  final List<RafikiAssets>? rafikiAssets;
  final String token;
  final bool success;
  final String message;

  Data({
    required this.user,
    required this.wallet,
    required this.transactionsModel,
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
      transactionsModel: json["transactions"] == null
          ? null
          : TransactionsModel.fromJson(json["transactions"]),
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
        transactionsModel: null,
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
  final WalletDb walletDb;
  final WalletAsset? walletAsset;

  Wallet({
    required this.walletDb,
    required this.walletAsset,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        walletDb: WalletDb.fromJson(json["walletDb"]),
        walletAsset: json["walletAsset"] == null
            ? null
            : WalletAsset.fromJson(json["walletAsset"]),
      );

  factory Wallet.initialState() => Wallet(
        walletDb: WalletDb.initialState(),
        walletAsset: WalletAsset.initialState(),
      );
}

class WalletAsset {
  //final String typename;
  final String code;
  final String id;
  final String liquidity;
  final int scale;

  WalletAsset({
    //required this.typename,
    required this.code,
    required this.id,
    required this.liquidity,
    required this.scale,
  });

  factory WalletAsset.fromJson(Map<String, dynamic> json) => WalletAsset(
        //typename: json["__typename"],
        code: json["code"],
        id: json["id"],
        liquidity: json["liquidity"],
        scale: json["scale"],
      );

  Map<String, dynamic> toJson() => {
        //"_Typename": typename,
        "code": code,
        "id": id,
        "liquidity": liquidity,
        "scale": scale,
      };

  factory WalletAsset.initialState() => WalletAsset(
        //typename: '',
        code: '',
        id: '',
        liquidity: '',
        scale: 0,
      );
}

class WalletDb {
  final String userId;
  final String rafikiId;
  final String walletType;

  final int postedDebits;
  final int pendingCredits;
  final int pendingDebits;
  final int postedCredits;

  final String id;
  final bool active;
  final String name;

  WalletDb({
    required this.userId,
    required this.rafikiId,
    required this.walletType,
    required this.postedDebits,
    required this.pendingCredits,
    required this.pendingDebits,
    required this.postedCredits,
    required this.id,
    required this.active,
    required this.name,
  });

  factory WalletDb.fromJson(Map<String, dynamic> json) => WalletDb(
        userId: json["userId"],
        rafikiId: json["rafikiId"],
        walletType: json["walletType"],
        postedDebits: json["postedDebits"] ?? 0,
        pendingCredits: json["pendingCredits"] ?? 0,
        pendingDebits: json["pendingDebits"] ?? 0,
        postedCredits: json["postedCredits"] ?? 0,
        id: json["id"],
        active: json["active"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "rafikiId": rafikiId,
        "walletType": walletType,
        "postedDebits": postedDebits,
        "pendingCredits": pendingCredits,
        "pendingDebits": pendingDebits,
        "postedCredits": postedCredits,
        "id": id,
        "active": active,
        "name": name,
      };

  factory WalletDb.initialState() => WalletDb(
        userId: '',
        rafikiId: '',
        walletType: '',
        postedDebits: 0,
        pendingCredits: 0,
        pendingDebits: 0,
        postedCredits: 0,
        id: '',
        active: false,
        name: '',
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
