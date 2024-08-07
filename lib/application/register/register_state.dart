part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final String? id;
  final String username;
  final String email;
  final String passwordHash;
  final bool mfaEnabled;
  final String mfaType;
  final FormSubmissionStatus formStatus;

  const RegisterState({
    this.id = '',
    this.username = '',
    this.email = '',
    this.passwordHash = '',
    this.mfaEnabled = false,
    this.mfaType = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? id,
    String? username,
    String? email,
    String? passwordHash,
    bool? mfaEnabled,
    String? mfaType,
    FormSubmissionStatus? formStatus,
  }) =>
      RegisterState(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        mfaEnabled: mfaEnabled ?? this.mfaEnabled,
        mfaType: mfaType ?? this.mfaType,
        formStatus: formStatus ?? this.formStatus,
      );

  RegisterState initialState() => const RegisterState(
        id: '',
        username: '',
        email: '',
        passwordHash: '',
        mfaEnabled: false,
        mfaType: '',
        formStatus: InitialFormStatus(),
      );

  @override
  List<Object> get props => [
        id ?? '',
        username,
        email,
        passwordHash,
        mfaEnabled,
        mfaType,
        formStatus,
      ];
}
