class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String passwordHash;
  final bool mfaEnabled;
  final String mfaType;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.passwordHash,
    required this.mfaEnabled,
    required this.mfaType,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
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
