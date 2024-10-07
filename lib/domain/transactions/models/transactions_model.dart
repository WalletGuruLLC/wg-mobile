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
  final List<CompletedIncomingPayment> completedIncomingPayments;
  //final List<dynamic> completedOutgoingPayments;

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
    required this.completedIncomingPayments,
    //required this.completedOutgoingPayments,
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
    List<CompletedIncomingPayment>? completedIncomingPayments,
    //List<dynamic>? completedOutgoingPayments,
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
        completedIncomingPayments:
            completedIncomingPayments ?? this.completedIncomingPayments,
        //completedOutgoingPayments: completedOutgoingPayments ?? this.completedOutgoingPayments,
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
      createdAt: DateTime.parse(json["createdAt"]),
      incomingPaymentId: json["incomingPaymentId"],
      incomingAmount: json["incomingAmount"] == null
          ? null
          : Amount.fromJson(json["incomingAmount"]),
      completedIncomingPayments: [],
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
        completedIncomingPayments: [],
      );
}

class CompletedIncomingPayment {
  final String id;
  final String state;
  final String description;
  final String value;
  final String assetCode;
  final int createdAt;
  final String debitAccountId;
  final String creditAccountId;

  CompletedIncomingPayment({
    required this.id,
    required this.state,
    required this.description,
    required this.value,
    required this.assetCode,
    required this.createdAt,
    required this.debitAccountId,
    required this.creditAccountId,
  });

  CompletedIncomingPayment copyWith({
    String? id,
    String? state,
    String? description,
    String? value,
    String? assetCode,
    int? createdAt,
    String? debitAccountId,
    String? creditAccountId,
  }) =>
      CompletedIncomingPayment(
        id: id ?? this.id,
        state: state ?? this.state,
        description: description ?? this.description,
        value: value ?? this.value,
        assetCode: assetCode ?? this.assetCode,
        createdAt: createdAt ?? this.createdAt,
        debitAccountId: debitAccountId ?? this.debitAccountId,
        creditAccountId: creditAccountId ?? this.creditAccountId,
      );

  factory CompletedIncomingPayment.fromJson(Map<String, dynamic> json) =>
      CompletedIncomingPayment(
        id: json["id"],
        state: json["state"],
        description: json["description"],
        value: json["value"],
        assetCode: json["assetCode"],
        createdAt: json["createdAt"],
        debitAccountId: json["debitAccountId"],
        creditAccountId: json["creditAccountId"],
      );
}

class Amount {
  String typename;
  int assetScale;
  String assetCode;
  String value;

  Amount({
    required this.typename,
    required this.assetScale,
    required this.assetCode,
    required this.value,
  });

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        typename: json["_Typename"],
        assetScale: json["assetScale"],
        assetCode: json["assetCode"],
        value: json["value"],
      );

  factory Amount.initialState() => Amount(
        typename: '',
        assetScale: 0,
        assetCode: '',
        value: '',
      );

  Map<String, dynamic> toJson() => {
        "_Typename": typename,
        "assetScale": assetScale,
        "assetCode": assetCode,
        "value": value,
      };
}
