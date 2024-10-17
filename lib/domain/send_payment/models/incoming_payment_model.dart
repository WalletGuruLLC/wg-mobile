import 'dart:math';

class IncomingPaymentModel {
  String type;
  String id;
  String provider;
  String ownerUser;
  String state;
  IncomingAmount incomingAmount;
  DateTime createdAt;
  DateTime expiresAt;

  IncomingPaymentModel({
    required this.type,
    required this.id,
    required this.provider,
    required this.ownerUser,
    required this.state,
    required this.incomingAmount,
    required this.createdAt,
    required this.expiresAt,
  });

  factory IncomingPaymentModel.fromJson(Map<String, dynamic> json) =>
      IncomingPaymentModel(
        type: json["type"],
        id: json["id"],
        provider: json["provider"] ?? "",
        ownerUser: json["ownerUser"],
        state: json["state"],
        incomingAmount: IncomingAmount.fromJson(json["incomingAmount"]),
        createdAt: DateTime.parse(json["createdAt"]),
        expiresAt: DateTime.parse(json["expiresAt"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "provider": provider,
        "ownerUser": ownerUser,
        "state": state,
        "incomingAmount": incomingAmount.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "expiresAt": expiresAt.toIso8601String(),
      };
}

class IncomingAmount {
  String typename;
  int assetScale;
  String assetCode;
  double value;

  IncomingAmount({
    required this.typename,
    required this.assetScale,
    required this.assetCode,
    required this.value,
  });

  factory IncomingAmount.fromJson(Map<String, dynamic> json) => IncomingAmount(
        typename: json["_Typename"],
        assetScale: json["assetScale"],
        assetCode: json["assetCode"],
        value: json["value"] != null
            ? ((int.parse(json["value"])) / pow(10, json["assetScale"]))
            : 0,
      );

  Map<String, dynamic> toJson() => {
        "_Typename": typename,
        "assetScale": assetScale,
        "assetCode": assetCode,
        "value": value,
      };
}
