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

  const LoginState({
    this.email = '',
    this.password = '',
    this.token = '',
    this.otp = '',
    this.customMessage = '',
    this.customMessageEs = '',
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
      ];
}
