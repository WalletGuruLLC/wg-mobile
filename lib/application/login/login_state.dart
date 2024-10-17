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
  final bool logOutSuccess;
  final User? user;
  final String forgotPasswordEmail;
  final String forgotPasswordOtp;
  final String forgotPasswordNewPassword;
  final FormSubmissionStatus formStatusForgotPassword;

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
    this.logOutSuccess = false,
    this.user,
    this.forgotPasswordEmail = '',
    this.forgotPasswordOtp = '',
    this.forgotPasswordNewPassword = '',
    this.formStatusForgotPassword = const InitialFormStatus(),
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
    bool? logOutSuccess,
    User? user,
    String? forgotPasswordEmail,
    String? forgotPasswordOtp,
    String? forgotPasswordNewPassword,
    FormSubmissionStatus? formStatusForgotPassword,
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
        logOutSuccess: logOutSuccess ?? this.logOutSuccess,
        user: user ?? this.user,
        forgotPasswordEmail: forgotPasswordEmail ?? this.forgotPasswordEmail,
        forgotPasswordOtp: forgotPasswordOtp ?? this.forgotPasswordOtp,
        forgotPasswordNewPassword:
            forgotPasswordNewPassword ?? this.forgotPasswordNewPassword,
        formStatusForgotPassword:
            formStatusForgotPassword ?? this.formStatusForgotPassword,
      );

  LoginState initialState() => LoginState(
      userId: '',
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      formStatus: const InitialFormStatus(),
      formStatusOtp: const InitialFormStatus(),
      token: '',
      otp: '',
      customMessage: '',
      customMessageEs: '',
      customCode: '',
      isFirstTime: true,
      logOutSuccess: false,
      forgotPasswordEmail: '',
      forgotPasswordOtp: '',
      forgotPasswordNewPassword: '',
      formStatusForgotPassword: const InitialFormStatus(),
      user: User.initialState());

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
        logOutSuccess,
        forgotPasswordEmail,
        forgotPasswordOtp,
        forgotPasswordNewPassword,
        formStatusForgotPassword,
      ];
}
