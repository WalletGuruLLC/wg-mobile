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
}
