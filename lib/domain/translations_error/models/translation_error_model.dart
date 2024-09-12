class TranslationErrorModel {
  final String id;
  final String description;
  final String language;
  final String text;

  TranslationErrorModel({
    required this.id,
    required this.description,
    required this.language,
    required this.text,
  });

  factory TranslationErrorModel.fromJson(Map<String, dynamic> json) {
    return TranslationErrorModel(
      id: json['id'],
      description: json['description'],
      language: json['language'],
      text: json['text'],
    );
  }
}
