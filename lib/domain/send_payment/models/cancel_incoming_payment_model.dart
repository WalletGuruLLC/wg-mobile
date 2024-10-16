class CancelIncomingPaymentModel {
    Payment payment;
    String typename;

    CancelIncomingPaymentModel({
        required this.payment,
        required this.typename,
    });

    factory CancelIncomingPaymentModel.fromJson(Map<String, dynamic> json) => CancelIncomingPaymentModel(
        payment: Payment.fromJson(json["payment"]),
        typename: json["__typename"],
    );

    Map<String, dynamic> toJson() => {
        "payment": payment.toJson(),
        "__typename": typename,
    };
}

class Payment {
    dynamic client;
    DateTime createdAt;
    DateTime expiresAt;
    String id;
    Amount incomingAmount;
    dynamic liquidity;
    Metadata metadata;
    Amount receivedAmount;
    String state;
    String walletAddressId;
    String typename;

    Payment({
        required this.client,
        required this.createdAt,
        required this.expiresAt,
        required this.id,
        required this.incomingAmount,
        required this.liquidity,
        required this.metadata,
        required this.receivedAmount,
        required this.state,
        required this.walletAddressId,
        required this.typename,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        client: json["client"],
        createdAt: DateTime.parse(json["createdAt"]),
        expiresAt: DateTime.parse(json["expiresAt"]),
        id: json["id"],
        incomingAmount: Amount.fromJson(json["incomingAmount"]),
        liquidity: json["liquidity"],
        metadata: Metadata.fromJson(json["metadata"]),
        receivedAmount: Amount.fromJson(json["receivedAmount"]),
        state: json["state"],
        walletAddressId: json["walletAddressId"],
        typename: json["__typename"],
    );

    Map<String, dynamic> toJson() => {
        "client": client,
        "createdAt": createdAt.toIso8601String(),
        "expiresAt": expiresAt.toIso8601String(),
        "id": id,
        "incomingAmount": incomingAmount.toJson(),
        "liquidity": liquidity,
        "metadata": metadata.toJson(),
        "receivedAmount": receivedAmount.toJson(),
        "state": state,
        "walletAddressId": walletAddressId,
        "__typename": typename,
    };
}

class Amount {
    String assetCode;
    int assetScale;
    String value;
    String typename;

    Amount({
        required this.assetCode,
        required this.assetScale,
        required this.value,
        required this.typename,
    });

    factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        assetCode: json["assetCode"],
        assetScale: json["assetScale"],
        value: json["value"],
        typename: json["__typename"],
    );

    Map<String, dynamic> toJson() => {
        "assetCode": assetCode,
        "assetScale": assetScale,
        "value": value,
        "__typename": typename,
    };
}

class Metadata {
    String type;
    String wgUser;
    String description;

    Metadata({
        required this.type,
        required this.wgUser,
        required this.description,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        type: json["type"],
        wgUser: json["wgUser"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "wgUser": wgUser,
        "description": description,
    };
}
