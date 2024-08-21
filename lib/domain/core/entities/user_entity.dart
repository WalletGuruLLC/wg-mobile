class UserEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String passwordHash;
  final bool mfaEnabled;
  final String mfaType;

  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.passwordHash,
    required this.mfaEnabled,
    required this.mfaType,
  });

  Map<String, dynamic> toJson() => {
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
