import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';

class ResponseModel {
  final int statusCode;
  final String customCode;
  final String customMessage;
  final String customMessageEs;
  final Data? data;
  final Wallet? wallet;
  final Rate? rates;

  ResponseModel({
    required this.statusCode,
    required this.customCode,
    required this.customMessage,
    required this.customMessageEs,
    required this.data,
    required this.wallet,
    required this.rates,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        statusCode: json["statusCode"] ?? 0,
        customCode: json["customCode"] ?? "",
        customMessage: json["customMessage"] ?? "",
        customMessageEs: json["customMessageEs"] ?? "",
        wallet: json["wallet"] != null
            ? (json["wallet"]["wallet"] != null
                ? Wallet.fromJson(json["wallet"]["wallet"])
                : Wallet.fromJson(json["wallet"]))
            : null,
        data: json["data"] != null && json["data"] is Map<String, dynamic>
            ? Data.fromJson(json["data"])
            : (json["data"] == "exist"
                ? Data.withMessage("exist")
                : Data.withMessage("don’t found")),
        rates: json["rates"] != null ? Rate.fromJson(json["rates"]) : null,
      );
}

class Data {
  final User? user;
  final Wallet? wallet;
  final List<TransactionsModel>? transactions;
  final List<RafikiAssets>? rafikiAssets;
  final String token;
  final bool success;
  final String message;
  final OutgoingPaymentResponse? outgoingPaymentResponse;
  final List<IncomingPayment>? incomingPayments;

  Data({
    required this.user,
    required this.wallet,
    required this.transactions,
    required this.rafikiAssets,
    required this.token,
    required this.success,
    required this.message,
    required this.outgoingPaymentResponse,
    required this.incomingPayments,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    User? user;
    if (json.containsKey("user") && json["user"] != null) {
      user = User.fromJson(json["user"]);
    } else if (!json.containsKey("user") &&
        json.isNotEmpty &&
        !json.containsKey("createOutgoingPayment")) {
      user = User.fromJson(json);
    }

    return Data(
      user: user,
      transactions: json.containsKey("transactions") &&
              json["transactions"] != null
          ? List<TransactionsModel>.from(
              json["transactions"].map((x) => TransactionsModel.fromJson(x)))
          : null,
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
      outgoingPaymentResponse: json.containsKey("createOutgoingPayment") &&
              json["createOutgoingPayment"] != null
          ? OutgoingPaymentResponse.fromJson(json["createOutgoingPayment"])
          : null,
      incomingPayments: json.containsKey("incomingPayments") &&
              json["incomingPayments"] != null
          ? List<IncomingPayment>.from(
              json["incomingPayments"].map((x) => IncomingPayment.fromJson(x)))
          : null,
    );
  }

  factory Data.initialState() => Data(
      user: null,
      transactions: [],
      wallet: null,
      rafikiAssets: null,
      token: '',
      success: false,
      message: '',
      outgoingPaymentResponse: null,
      incomingPayments: null);

  factory Data.withMessage(String message) => Data(
      user: null,
      transactions: [],
      wallet: null,
      rafikiAssets: null,
      token: '',
      success: false,
      message: message,
      outgoingPaymentResponse: null,
      //transactionsModel: null,
      incomingPayments: null);

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
  final String code;
  final String id;
  final String liquidity;
  final int scale;

  WalletAsset({
    required this.code,
    required this.id,
    required this.liquidity,
    required this.scale,
  });

  factory WalletAsset.fromJson(Map<String, dynamic> json) => WalletAsset(
        code: json["code"],
        id: json["id"],
        liquidity: json["liquidity"],
        scale: json["scale"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "id": id,
        "liquidity": liquidity,
        "scale": scale,
      };

  factory WalletAsset.initialState() => WalletAsset(
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
  final String walletAddress;
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
    required this.walletAddress,
  });

  factory WalletDb.fromJson(Map<String, dynamic> json) => WalletDb(
        userId: json["userId"],
        rafikiId: json["rafikiId"] ?? '',
        walletType: json["walletType"],
        postedDebits: json["postedDebits"] ?? 0,
        pendingCredits: json["pendingCredits"] ?? 0,
        pendingDebits: json["pendingDebits"] ?? 0,
        postedCredits: json["postedCredits"] ?? 0,
        id: json["id"],
        active: json["active"],
        walletAddress: json["walletAddress"],
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
        "walletAddress": walletAddress,
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
        walletAddress: '',
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

class Rate {
  final double mxn;
  final double jpy;
  final double eur;
  final double usd;

  Rate({
    required this.mxn,
    required this.jpy,
    required this.eur,
    required this.usd,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        mxn: json["MXN"]?.toDouble() ?? 0.0,
        jpy: json["JPY"]?.toDouble() ?? 0.0,
        eur: json["EUR"]?.toDouble() ?? 0.0,
        usd: json["USD"]?.toDouble() ?? 0.0,
      );
}

class OutgoingPaymentResponse {
  final OutgoingPayment payment;

  OutgoingPaymentResponse({
    required this.payment,
  });

  factory OutgoingPaymentResponse.fromJson(Map<String, dynamic> json) {
    return OutgoingPaymentResponse(
      payment: OutgoingPayment.fromJson(json['payment']),
    );
  }
}

class OutgoingPayment {
  final String createdAt;
  final String? error;
  final String? metadata;
  final String id;
  final String walletAddressId;
  final Amount receiveAmount;
  final String receiver;
  final Amount debitAmount;
  final Amount sentAmount;
  final String state;
  final int stateAttempts;

  OutgoingPayment({
    required this.createdAt,
    this.error,
    this.metadata,
    required this.id,
    required this.walletAddressId,
    required this.receiveAmount,
    required this.receiver,
    required this.debitAmount,
    required this.sentAmount,
    required this.state,
    required this.stateAttempts,
  });

  factory OutgoingPayment.fromJson(Map<String, dynamic> json) {
    return OutgoingPayment(
      createdAt: json['createdAt'],
      error: json['error'],
      metadata: json['metadata'],
      id: json['id'],
      walletAddressId: json['walletAddressId'],
      receiveAmount: Amount.fromJson(json['receiveAmount']),
      receiver: json['receiver'],
      debitAmount: Amount.fromJson(json['debitAmount']),
      sentAmount: Amount.fromJson(json['sentAmount']),
      state: json['state'],
      stateAttempts: json['stateAttempts'],
    );
  }
}

class Amount {
  final String assetCode;
  final int assetScale;
  final String value;

  Amount({
    required this.assetCode,
    required this.assetScale,
    required this.value,
  });

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      assetCode: json['assetCode'],
      assetScale: json['assetScale'],
      value: json['value'],
    );
  }
}

class IncomingPayment {
  final String type;
  final String id;
  final String walletAddressId;
  final String state;
  final IncomingAmount incomingAmount;
  final DateTime createdAt;
  final DateTime expiresAt;

  IncomingPayment({
    required this.type,
    required this.id,
    required this.walletAddressId,
    required this.state,
    required this.incomingAmount,
    required this.createdAt,
    required this.expiresAt,
  });

  factory IncomingPayment.fromJson(Map<String, dynamic> json) {
    return IncomingPayment(
      type: json['type'] ?? '',
      id: json['id'] ?? '',
      walletAddressId: json['walletAddressId'] ?? '',
      state: json['state'] ?? '',
      incomingAmount: IncomingAmount.fromJson(json['incomingAmount']),
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: DateTime.parse(json['expiresAt']),
    );
  }
}

class IncomingAmount {
  final String typeName;
  final int assetScale;
  final String assetCode;
  final String value;

  IncomingAmount({
    required this.typeName,
    required this.assetScale,
    required this.assetCode,
    required this.value,
  });

  factory IncomingAmount.fromJson(Map<String, dynamic> json) {
    return IncomingAmount(
      typeName: json['_typename'] ?? '',
      assetScale: json['assetScale'] ?? 0,
      assetCode: json['assetCode'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_typename': typeName,
      'assetScale': assetScale,
      'assetCode': assetCode,
      'value': value,
    };
  }
}
