// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    String id;
    String username;
    String email;
    String passwordHash;
    bool mfaEnabled;
    String mfaType;

    RegisterModel({
        required this.id,
        required this.username,
        required this.email,
        required this.passwordHash,
        required this.mfaEnabled,
        required this.mfaType,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        passwordHash: json["passwordHash"],
        mfaEnabled: json["mfaEnabled"],
        mfaType: json["mfaType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "passwordHash": passwordHash,
        "mfaEnabled": mfaEnabled,
        "mfaType": mfaType,
    };
}
