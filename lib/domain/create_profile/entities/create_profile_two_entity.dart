import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';

class CreateProfileTwoEntity extends BaseProfileEntity {
  final String phone;
  final String socialSecurityNumber;

  CreateProfileTwoEntity({
    required String id,
    required String email,
    required this.socialSecurityNumber,
    required this.phone,
  }) : super(id, email);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "socialSecurityNumber": socialSecurityNumber,
        "phone": phone,
      };
}
