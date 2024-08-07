part of 'user_cubit.dart';

class UserState {
  final String? id;
  final String username;
  final String email;
  final String passwordHash;
  final bool mfaEnabled;
  final String mfaType;
  final FormSubmissionStatus formStatus;

  UserState({
    this.id = '',
    this.username = '',
    this.email = '',
    this.passwordHash = '',
    this.mfaEnabled = false,
    this.mfaType = '',
    this.formStatus = const InitialFormStatus(),
  });

  UserState copyWith({
    String? id,
    String? username,
    String? email,
    String? passwordHash,
    bool? mfaEnabled,
    String? mfaType,
    FormSubmissionStatus? formStatus,
  }) =>
      UserState(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        mfaEnabled: mfaEnabled ?? this.mfaEnabled,
        mfaType: mfaType ?? this.mfaType,
        formStatus: formStatus ?? this.formStatus,
      );

  UserState initialState() => UserState(
        id: '',
        username: '',
        email: '',
        passwordHash: '',
        mfaEnabled: false,
        mfaType: '',
        formStatus: const InitialFormStatus(),
      );
}
