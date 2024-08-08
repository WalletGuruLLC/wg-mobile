import 'package:wallet_guru/domain/core/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.passwordHash,
    required super.mfaEnabled,
    required super.mfaType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] as String? ?? '',
        username: json["username"] as String? ?? '',
        email: json["email"] as String? ?? '',
        passwordHash: json["passwordHash"] as String? ?? '',
        mfaEnabled: json["mfaEnabled"] as bool? ?? false,
        mfaType: json["mfaType"] as String? ?? '',
      );
}
