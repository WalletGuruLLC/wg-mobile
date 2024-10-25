import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';

class CreateProfileEntity extends BaseProfileEntity {
  final String? firstName;
  final String? lastName;
  final String phone;
  final bool termsConditions;
  final bool privacyPolicy;
//
  final String socialSecurityNumber;
  final String? identificationType;
  final String? identificationNumber;
//
  final String country;
  final String stateLocation;
  final String city;
  final String zipCode;
  final String address;

  CreateProfileEntity({
    required String id,
    required String email,
    this.firstName,
    this.lastName,
    required this.phone,
    required this.termsConditions,
    required this.privacyPolicy,
    //
    required this.socialSecurityNumber,
    this.identificationType,
    this.identificationNumber,
    //
    required this.country,
    required this.stateLocation,
    required this.city,
    required this.zipCode,
    required this.address,
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
        //
        "socialSecurityNumber": socialSecurityNumber,
        "identificationType": identificationType,
        "identificationNumber": identificationNumber,
        //
        "country": country,
        "stateLocation": stateLocation,
        "city": city,
        "zipCode": zipCode,
        "address": address,
      };
}
