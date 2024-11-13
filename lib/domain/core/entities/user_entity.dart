import 'dart:io';

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
  final String phoneCode;
  final File pictureFile;

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
    required this.phoneCode,
    required this.pictureFile,
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
    String? phoneCode,
    File? pictureFile,
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
      phoneCode: phoneCode ?? this.phoneCode,
      pictureFile: pictureFile ?? this.pictureFile,
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
      "phoneCode": phoneCode,
      "pictureFile": pictureFile,
    };
  }

  factory UserEntity.fromUser(User user) {
    final phoneCode = _extractPhoneCode(user.phone);
    final phoneNumber = _extractPhoneNumber(user.phone);
    return UserEntity(
      email: user.email,
      picture: user.picture,
      phone: phoneNumber,
      address: user.address,
      city: user.city,
      country: user.country,
      zipCode: user.zipCode,
      stateLocation: user.stateLocation,
      lastName: user.lastName,
      firstName: user.firstName,
      id: user.id,
      active: user.active,
      phoneCode: phoneCode,
      pictureFile: File(''),
    );
  }

  String get fullName => '$firstName $lastName';

  static String _extractPhoneCode(String phone) {
    final regex = RegExp(r'^(\+\d+)-');
    final match = regex.firstMatch(phone);
    if (match != null) {
      return match.group(1) ?? '';
    }
    return '';
  }

  static String _extractPhoneNumber(String phone) {
    final regex = RegExp(r'^\+\d+-(.+)$');
    final match = regex.firstMatch(phone);
    if (match != null) {
      return match.group(1) ?? '';
    }
    return '';
  }

  bool get isLongName {
    final nameParts = fullName.split(' ');
    return nameParts.length >= 4;
  }
}
