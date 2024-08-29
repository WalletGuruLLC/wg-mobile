import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';

class CreateProfileThreeEntity extends BaseProfileEntity {
  final String country;
  final String stateLocation;
  final String city;
  final String zipCode;
  final String address;

  CreateProfileThreeEntity({
    required String id,
    required this.country,
    required this.stateLocation,
    required this.city,
    required this.zipCode,
    required this.address,
  }) : super(id);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "stateLocation": stateLocation,
        "city": city,
        "zipCode": zipCode,
        "address": address,
      };
}
