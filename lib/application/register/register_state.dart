part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final String? firstName;
  final String? lastName;
  final String email;
  final String passwordHash;
  final bool mfaEnabled;
  final String mfaType;
  final String customCode;
  final String customMessage;
  final FormSubmissionStatus formStatus;

  const RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.passwordHash = '',
    this.mfaEnabled = false,
    this.mfaType = '',
    this.customCode = '',
    this.customMessage = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? passwordHash,
    bool? mfaEnabled,
    String? mfaType,
    String? customCode,
    String? customMessage,
    FormSubmissionStatus? formStatus,
  }) =>
      RegisterState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        mfaEnabled: mfaEnabled ?? this.mfaEnabled,
        mfaType: mfaType ?? this.mfaType,
        customCode: customCode ?? this.customCode,
        customMessage: customMessage ?? this.customMessage,
        formStatus: formStatus ?? this.formStatus,
      );

  RegisterState initialState() => const RegisterState(
        firstName: '',
        lastName: '',
        email: '',
        passwordHash: '',
        mfaEnabled: false,
        mfaType: '',
        customCode: '',
        customMessage: '',
        formStatus: InitialFormStatus(),
      );

  @override
  List<Object> get props => [
        firstName ?? '',
        lastName ?? '',
        email,
        passwordHash,
        mfaEnabled,
        mfaType,
        customCode,
        customMessage,
        formStatus,
      ];
}
