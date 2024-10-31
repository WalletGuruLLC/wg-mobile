import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';

class CreateProfileOneEntity extends BaseProfileEntity {
  final bool termsConditions;
  final bool privacyPolicy;
  final String country;
  final String stateLocation;
  final String city;
  final String zipCode;
  final String address;

  CreateProfileOneEntity({
    required String id,
    required String email,
    required this.country,
    required this.stateLocation,
    required this.city,
    required this.termsConditions,
    required this.privacyPolicy,
    required this.address,
    required this.zipCode,
  }) : super(id, email);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "termsConditions": termsConditions,
        "privacyPolicy": privacyPolicy,
        // Specific Information to update
        "country": country,
        "stateLocation": stateLocation,
        "city": city,
        "zipCode": zipCode,
        "address": address,
      };
}
