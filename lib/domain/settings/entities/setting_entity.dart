class SettingEntity {
  final String id;
  final String belongs;
  final String key;
  final String value;

  SettingEntity({
    required this.id,
    required this.belongs,
    required this.key,
    required this.value,
  });

  factory SettingEntity.fromJson(Map<String, dynamic> json) {
    return SettingEntity(
      id: json['id'],
      belongs: json['belongs'],
      key: json['key'],
      value: json['value'],
    );
  }
}
