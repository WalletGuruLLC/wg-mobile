import 'package:wallet_guru/domain/core/entities/user_entity.dart';

class UserModel extends UserEntity {
    UserModel({
        required super.id,
        required super.username,
        required super.email,
        required super.passwordHash,
        required super.mfaEnabled,
        required super. mfaType,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        passwordHash: json["passwordHash"],
        mfaEnabled: json["mfaEnabled"],
        mfaType: json["mfaType"],
    );
}
