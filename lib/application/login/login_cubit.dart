import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/domain/login/repositories/login_repository.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  final registerRepository = Injector.resolve<LoginRepository>();

  void emitSignInUser() async {
    emit(
      state.copyWith(formStatus: FormSubmitting()),
    );
    final verifyEmailOtp =
        await registerRepository.signInUser(state.email, state.password);
    verifyEmailOtp.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.message)),
        ));
      },
      (singInUser) {
        emit(state.copyWith(
          customMessage: singInUser.customCode,
          customMessageEs: singInUser.customMessageEs,
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }

  void setUserEmail(String? email) async {
    emit(state.copyWith(email: email));
  }

  void setUserPassword(String? password) async {
    emit(state.copyWith(password: password));
  }

  void setOtp(String? otp) async {
    emit(state.copyWith(otp: otp));
  }

  void emitVerifyEmailOtp() async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    final verifyEmailOtp =
        await registerRepository.verifyEmailOtp(state.email, state.otp);
    verifyEmailOtp.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.message)),
        ));
      },
      (verifiedUser) {
        emit(state.copyWith(
          customMessage: verifiedUser.customCode,
          customMessageEs: verifiedUser.customMessageEs,
          token: verifiedUser.data!.token,
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }
}
