part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final String token;
  final FormSubmissionStatus formStatus;
  final FormSubmissionStatus formStatusOtp;
  final String otp;
  final String customMessage;
  final String customMessageEs;
  final String customCode;

  const LoginState({
    this.email = '',
    this.password = '',
    this.token = '',
    this.otp = '',
    this.customMessage = '',
    this.customMessageEs = '',
    this.customCode = '',
    this.formStatus = const InitialFormStatus(),
    this.formStatusOtp = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? token,
    FormSubmissionStatus? formStatus,
    FormSubmissionStatus? formStatusOtp,
    String? otp,
    String? customMessage,
    String? customMessageEs,
    String? customCode,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        formStatusOtp: formStatusOtp ?? this.formStatusOtp,
        token: token ?? this.token,
        otp: otp ?? this.otp,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        customCode: customCode ?? this.customCode,
      );

  LoginState initialState() => const LoginState(
        email: '',
        password: '',
        formStatus: InitialFormStatus(),
        formStatusOtp: InitialFormStatus(),
        token: '',
        otp: '',
        customMessage: '',
        customMessageEs: '',
        customCode: '',
      );

  @override
  List<Object> get props => [
        email,
        password,
        formStatus,
        formStatusOtp,
        token,
        otp,
        customMessage,
        customMessageEs,
        customCode,
      ];
}
