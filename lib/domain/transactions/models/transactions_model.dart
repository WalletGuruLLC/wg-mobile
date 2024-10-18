import 'dart:math';

class TransactionsModel {
  String type;
  String? outgoingPaymentId;
  String walletAddressId;
  String state;
  String? receiver;
  Amount? receiveAmount;
  DateTime createdAt;
  String? incomingPaymentId;
  Amount? incomingAmount;
  String senderUrl;
  String receiverUrl;

  TransactionsModel({
    required this.type,
    this.outgoingPaymentId,
    required this.walletAddressId,
    required this.state,
    this.receiver,
    this.receiveAmount,
    required this.createdAt,
    this.incomingPaymentId,
    this.incomingAmount,
    required this.senderUrl,
    required this.receiverUrl,
  });

  TransactionsModel copyWith({
    String? type,
    String? outgoingPaymentId,
    String? walletAddressId,
    String? state,
    String? receiver,
    Amount? receiveAmount,
    DateTime? createdAt,
    String? incomingPaymentId,
    Amount? incomingAmount,
    String? senderUrl,
    String? receiverUrl,
  }) =>
      TransactionsModel(
        type: type ?? this.type,
        outgoingPaymentId: outgoingPaymentId ?? this.outgoingPaymentId,
        walletAddressId: walletAddressId ?? this.walletAddressId,
        state: state ?? this.state,
        receiver: receiver ?? this.receiver,
        receiveAmount: receiveAmount ?? this.receiveAmount,
        createdAt: createdAt ?? this.createdAt,
        incomingPaymentId: incomingPaymentId ?? this.incomingPaymentId,
        incomingAmount: incomingAmount ?? this.incomingAmount,
        senderUrl: senderUrl ?? this.senderUrl,
        receiverUrl: receiverUrl ?? this.receiverUrl,
      );

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    return TransactionsModel(
      type: json["type"],
      outgoingPaymentId: json["outgoingPaymentId"],
      walletAddressId: json["walletAddressId"],
      state: json["state"],
      receiver: json["receiver"],
      receiveAmount: json["receiveAmount"] == null
          ? null
          : Amount.fromJson(json["receiveAmount"]),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
      incomingPaymentId: json["incomingPaymentId"],
      incomingAmount: json["incomingAmount"] == null
          ? null
          : Amount.fromJson(json["incomingAmount"]),
      senderUrl: json["senderUrl"],
      receiverUrl: json["receiverUrl"],
    );
  }

  factory TransactionsModel.initialState() => TransactionsModel(
        type: '',
        outgoingPaymentId: '',
        walletAddressId: '',
        state: '',
        receiver: '',
        receiveAmount: Amount.initialState(),
        createdAt: DateTime.now(),
        incomingPaymentId: '',
        incomingAmount: Amount.initialState(),
        senderUrl: '',
        receiverUrl: '',
      );
}

class Amount {
  String typename;
  int assetScale;
  String assetCode;
  double value;

  Amount({
    required this.typename,
    required this.assetScale,
    required this.assetCode,
    required this.value,
  });

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        typename: json["typename"],
        assetScale: json["assetScale"],
        assetCode: json["assetCode"],
        value: json["value"] != null
            ? ((int.parse(json["value"])) / pow(10, json["assetScale"]))
            : 0,
      );

  factory Amount.initialState() => Amount(
        typename: '',
        assetScale: 0,
        assetCode: '',
        value: 0.0,
      );

  Map<String, dynamic> toJson() => {
        "_Typename": typename,
        "assetScale": assetScale,
        "assetCode": assetCode,
        "value": value,
      };
}
