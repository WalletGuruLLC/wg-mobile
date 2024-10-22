class TransactionMetadata {
  final String type;
  final String description;
  final String wgUser;

  TransactionMetadata({
    required this.type,
    required this.description,
    required this.wgUser,
  });

  factory TransactionMetadata.fromJson(Map<String, dynamic> json) {
    return TransactionMetadata(
      type: json["type"] ?? "USER",
      description: json["description"] ?? "",
      wgUser: json["wgUser"] ?? "",
    );
  }

  factory TransactionMetadata.defaultUser() => TransactionMetadata(
    type: "USER",
    description: "",
    wgUser: "",
  );
}