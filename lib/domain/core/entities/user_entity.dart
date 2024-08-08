class UserEntity {
  final String id;
  final String username;
  final String email;
  final String passwordHash;
  final bool mfaEnabled;
  final String mfaType;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.passwordHash,
    required this.mfaEnabled,
    required this.mfaType,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "passwordHash": passwordHash,
        "mfaEnabled": mfaEnabled,
        "mfaType": mfaType,
      };

  Map<String, dynamic> toSignInJson() => {
        "email": email,
        "password": passwordHash,
      };
}
