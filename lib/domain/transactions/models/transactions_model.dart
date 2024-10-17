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
      );

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    /*List<CompletedIncomingPayment> payments =
        json["completedIncomingPayments"] == null
            ? []
            : List<CompletedIncomingPayment>.from(
                json["completedIncomingPayments"]!
                    .map((x) => CompletedIncomingPayment.fromJson(x)));

    // Ordenar la lista de pagos de más reciente a más antiguo
    payments.sort((a, b) => b.createdAt.compareTo(a.createdAt));*/

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
