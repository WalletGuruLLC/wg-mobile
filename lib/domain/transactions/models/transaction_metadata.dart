class TransactionMetadata {
  final String type;
  final String description;
  final String wgUser;
  final String activityId;
  final String contentName;

  TransactionMetadata({
    required this.type,
    required this.description,
    required this.wgUser,
    required this.activityId,
    required this.contentName,
  });

  factory TransactionMetadata.fromJson(Map<String, dynamic> json) {
    return TransactionMetadata(
      type: json["type"] ?? "USER",
      description: json["description"] ?? "",
      wgUser: json["wgUser"] ?? "",
      activityId: json["activityId"] ?? "",
      contentName: json["contentName"] ?? "",
    );
  }

  factory TransactionMetadata.defaultUser() => TransactionMetadata(
    type: "USER",
    description: "",
    wgUser: "",
    activityId: "",
    contentName: "",
  );
}