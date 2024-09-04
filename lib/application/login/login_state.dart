part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String token;
  final bool isFirstTime;
  final FormSubmissionStatus formStatus;
  final FormSubmissionStatus formStatusOtp;
  final String otp;
  final String customMessage;
  final String customMessageEs;
  final String customCode;

  const LoginState({
    this.userId = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.token = '',
    this.otp = '',
    this.customMessage = '',
    this.customMessageEs = '',
    this.customCode = '',
    this.isFirstTime = true,
    this.formStatus = const InitialFormStatus(),
    this.formStatusOtp = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? token,
    FormSubmissionStatus? formStatus,
    FormSubmissionStatus? formStatusOtp,
    String? otp,
    String? customMessage,
    String? customMessageEs,
    String? customCode,
    bool? isFirstTime,
  }) =>
      LoginState(
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        isFirstTime: isFirstTime ?? this.isFirstTime,
        formStatus: formStatus ?? this.formStatus,
        formStatusOtp: formStatusOtp ?? this.formStatusOtp,
        token: token ?? this.token,
        otp: otp ?? this.otp,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        customCode: customCode ?? this.customCode,
      );

  LoginState initialState() => const LoginState(
        userId: '',
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        formStatus: InitialFormStatus(),
        formStatusOtp: InitialFormStatus(),
        token: '',
        otp: '',
        customMessage: '',
        customMessageEs: '',
        customCode: '',
        isFirstTime: true,
      );

  @override
  List<Object> get props => [
        userId,
        firstName,
        lastName,
        email,
        password,
        formStatus,
        formStatusOtp,
        token,
        otp,
        customMessage,
        customMessageEs,
        customCode,
        isFirstTime,
      ];
}
