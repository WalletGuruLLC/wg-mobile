abstract class BaseProfileEntity {
  final String id;
  final String email;

  BaseProfileEntity(this.id, this.email);

  Map<String, dynamic> toJson();
}
