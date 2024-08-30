import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';

class CreateProfileOneEntity extends BaseProfileEntity {
  final String firstName;
  final String lastName;
  final String phone;
  final bool termsConditions;
  final bool privacyPolicy;

  CreateProfileOneEntity({
    required String id,
    required String email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.termsConditions,
    required this.privacyPolicy,
  }) : super(id, email);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "termsConditions": termsConditions,
        "privacyPolicy": privacyPolicy,
      };
}
