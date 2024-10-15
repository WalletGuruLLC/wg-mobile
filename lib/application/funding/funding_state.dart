part of 'funding_cubit.dart';

class FundingState extends Equatable {
  final String? firstName;
  final String? lastName;
  final String email;
  final String passwordHash;
  final bool mfaEnabled;
  final String mfaType;
  final String customCode;
  final String customMessage;
  final FormSubmissionStatus formStatus;
  final String customMessageEs;

  const FundingState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.passwordHash = '',
    this.mfaEnabled = false,
    this.mfaType = '',
    this.customCode = '',
    this.customMessage = '',
    this.formStatus = const InitialFormStatus(),
    this.customMessageEs = '',
  });

  FundingState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? passwordHash,
    bool? mfaEnabled,
    String? mfaType,
    String? customCode,
    String? customMessage,
    FormSubmissionStatus? formStatus,
    final String? customMessageEs,
  }) =>
      FundingState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        mfaEnabled: mfaEnabled ?? this.mfaEnabled,
        mfaType: mfaType ?? this.mfaType,
        customCode: customCode ?? this.customCode,
        customMessage: customMessage ?? this.customMessage,
        formStatus: formStatus ?? this.formStatus,
        customMessageEs: customMessageEs ?? this.customMessageEs,
      );

  FundingState initialState() => const FundingState(
        firstName: '',
        lastName: '',
        email: '',
        passwordHash: '',
        mfaEnabled: false,
        mfaType: '',
        customCode: '',
        customMessage: '',
        formStatus: InitialFormStatus(),
        customMessageEs: '',
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
        customMessageEs,
      ];
}
