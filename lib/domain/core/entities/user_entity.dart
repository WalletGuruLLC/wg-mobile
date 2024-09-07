import 'package:wallet_guru/domain/core/models/response_model.dart';

class UserEntity {
  final String email;
  final String picture;
  final String phone;
  final String address;
  final String city;
  final String country;
  final String zipCode;
  final String stateLocation;
  final String lastName;
  final String firstName;
  final String id;
  final bool active;

  UserEntity({
    required this.email,
    required this.picture,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.lastName,
    required this.firstName,
    required this.id,
    required this.active,
    required this.phone,
    required this.address,
    required this.stateLocation,
  });

  UserEntity copyWith({
    int? state,
    String? email,
    String? picture,
    String? phone,
    String? address,
    String? city,
    String? country,
    String? zipCode,
    String? stateLocation,
    String? lastName,
    String? firstName,
    String? id,
    bool? active,
  }) {
    return UserEntity(
      email: email ?? this.email,
      picture: picture ?? this.picture,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      id: id ?? this.id,
      active: active ?? this.active,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      stateLocation: stateLocation ?? this.stateLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "picture": picture,
      "phone": phone,
      "address": address,
      "city": city,
      "country": country,
      "zipCode": zipCode,
      "stateLocation": stateLocation,
      "lastName": lastName,
      "firstName": firstName,
      "id": id,
      "active": active,
    };
  }

  factory UserEntity.fromUser(User user) {
    return UserEntity(
      email: user.email,
      picture: user.picture,
      phone: user.phone,
      address: user.address,
      city: user.city,
      country: user.country,
      zipCode: user.zipCode,
      stateLocation: user.stateLocation,
      lastName: user.lastName,
      firstName: user.firstName,
      id: user.id,
      active: user.active,
    );
  }
}
