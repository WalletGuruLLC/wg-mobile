part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final String token;
  final FormSubmissionStatus formStatus;

  const LoginState({
    this.email = '',
    this.password = '',
    this.token = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? token,
    FormSubmissionStatus? formStatus,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        token: token ?? this.token,
      );

  LoginState initialState() => const LoginState(
        email: '',
        password: '',
        formStatus: InitialFormStatus(),
        token: '',
      );

  @override
  List<Object> get props => [
        email,
        password,
        formStatus,
        token,
      ];
}
