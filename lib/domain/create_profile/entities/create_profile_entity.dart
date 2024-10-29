import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';

class CreateProfileEntity extends BaseProfileEntity {
  final String phone;
  final bool termsConditions;
  final bool privacyPolicy;
//
  final String socialSecurityNumber;
//
  final String country;
  final String stateLocation;
  final String city;
  final String zipCode;
  final String address;
  final DateTime dateOfBirth;

  CreateProfileEntity({
    required String id,
    required String email,
    required this.phone,
    required this.termsConditions,
    required this.privacyPolicy,
    //
    required this.socialSecurityNumber,
    //
    required this.country,
    required this.stateLocation,
    required this.city,
    required this.zipCode,
    required this.address,
    required this.dateOfBirth,
  }) : super(id, email);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "termsConditions": termsConditions,
        "privacyPolicy": privacyPolicy,
        //
        "socialSecurityNumber": socialSecurityNumber,
        //
        "country": country,
        "stateLocation": stateLocation,
        "city": city,
        "zipCode": zipCode,
        "address": address,
        "dateOfBirth": dateOfBirth.toIso8601String(),
      };

  Map<String, dynamic> userLocationToJson() => {
        // General Information to update
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
  Map<String, dynamic> userPersonalInformationToJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "socialSecurityNumber": socialSecurityNumber,
      };

  Map<String, dynamic> userDateOfBirthToJson() => {
        "id": id,
        "email": email,
        "dateOfBirth": dateOfBirth.toIso8601String(),
      };
}
