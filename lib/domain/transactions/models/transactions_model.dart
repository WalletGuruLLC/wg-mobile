class TransactionsModel {
  final List<CompletedIncomingPayment> completedIncomingPayments;
  //final List<dynamic> completedOutgoingPayments;

  TransactionsModel({
    required this.completedIncomingPayments,
    //required this.completedOutgoingPayments,
  });

  TransactionsModel copyWith({
    List<CompletedIncomingPayment>? completedIncomingPayments,
    //List<dynamic>? completedOutgoingPayments,
  }) =>
      TransactionsModel(
        completedIncomingPayments:
            completedIncomingPayments ?? this.completedIncomingPayments,
        //completedOutgoingPayments: completedOutgoingPayments ?? this.completedOutgoingPayments,
      );

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
        completedIncomingPayments: json["completedIncomingPayments"] == null
            ? []
            : List<CompletedIncomingPayment>.from(
                json["completedIncomingPayments"]!
                    .map((x) => CompletedIncomingPayment.fromJson(x))),
        //completedOutgoingPayments: json["completedOutgoingPayments"] == null ? [] : List<dynamic>.from(json["completedOutgoingPayments"]!.map((x) => x)),
      );

  factory TransactionsModel.initialState() => TransactionsModel(
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
