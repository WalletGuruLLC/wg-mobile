import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';

class CreateProfileThreeEntity extends BaseProfileEntity {
  final DateTime dateOfBirth;

  CreateProfileThreeEntity({
    required String id,
    required String email,
    required this.dateOfBirth,
  }) : super(id, email);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "dateOfBirth": dateOfBirth.toIso8601String(),
      };
}
