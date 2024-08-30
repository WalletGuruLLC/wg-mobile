import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';

class CreateProfileTwoEntity extends BaseProfileEntity {
  final String socialSecurityNumber;
  final String identificationType;
  final String identificationNumber;

  CreateProfileTwoEntity({
    required String id,
    required String email,
    required this.socialSecurityNumber,
    required this.identificationType,
    required this.identificationNumber,
  }) : super(id, email);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "socialSecurityNumber": socialSecurityNumber,
        "identificationType": identificationType,
        "identificationNumber": identificationNumber,
      };
}
