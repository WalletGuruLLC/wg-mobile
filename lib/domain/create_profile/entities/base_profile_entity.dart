abstract class BaseProfileEntity {
  final String id;

  BaseProfileEntity(this.id);

  Map<String, dynamic> toJson();
}
