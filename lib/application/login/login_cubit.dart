import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/domain/login/repositories/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  final registerRepository = Injector.resolve<LoginRepository>();

  void emitSignInUser() async {
    emit(
      state.copyWith(formStatusLogin: FormSubmitting()),
    );
    final verifyEmailOtp =
        await registerRepository.signInUser(state.email, state.password);
    verifyEmailOtp.fold(
      (error) {
        emit(state.copyWith(
          formStatusLogin:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (singInUser) {
        emit(state.copyWith(
          customMessage: singInUser.customCode,
          customMessageEs: singInUser.customMessageEs,
          formStatusLogin: SubmissionSuccess(),
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

  void cleanFormStatus() async {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
  }

  void cleanFormStatusLogin() async {
    emit(state.copyWith(formStatusLogin: const InitialFormStatus()));
  }

  void cleanFormStatusOtp() async {
    emit(state.copyWith(formStatusOtp: const InitialFormStatus()));
  }

  void cleanFormStatusForgotPassword() async {
    emit(state.copyWith(formStatusForgotPassword: const InitialFormStatus()));
  }

  void initialStatus() async {
    emit(state.initialState());
  }

  void emitVerifyEmailOtp(String email) async {
    emit(state.copyWith(formStatusOtp: FormSubmitting()));
    final verifyEmailOtp =
        await registerRepository.verifyEmailOtp(email, state.otp);
    verifyEmailOtp.fold(
      (error) {
        emit(state.copyWith(
          formStatusOtp:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (verifiedUser) {
        emit(state.copyWith(
          customMessage: verifiedUser.customCode,
          customMessageEs: verifiedUser.customMessageEs,
          token: verifiedUser.data!.token,
          userId: verifiedUser.data!.user!.id,
          firstName: verifiedUser.data!.user!.firstName,
          lastName: verifiedUser.data!.user!.lastName,
          email: verifiedUser.data!.user!.email,
          formStatusOtp: SubmissionSuccess(),
          isFirstTime: verifiedUser.data!.user!.first,
          user: verifiedUser.data!.user,
        ));
      },
    );
  }

  void emitResendOtp(String email) async {
    final verifyEmailOtp = await registerRepository.resendOtp(email);
    verifyEmailOtp.fold(
      (error) {
        emit(state.copyWith(
          formStatusOtp:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (resendCode) {
        emit(state.copyWith(
          customMessage: resendCode.customCode,
          customMessageEs: resendCode.customMessageEs,
        ));
      },
    );
  }

  void emitLogOut() async {
    final logOut = await registerRepository.logOut();
    logOut.fold(
      (error) {
        emit(state.copyWith(
          formStatusOtp:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (logOut) {
        emit(state.copyWith(
          logOutSuccess: true,
        ));
      },
    );
  }

  void setUserForgotPasswordEmail(String? email) async {
    emit(state.copyWith(forgotPasswordEmail: email));
  }

  void setForgotPasswordOtp(String? otp) async {
    emit(state.copyWith(forgotPasswordOtp: otp));
  }

  void setUserForgotPasswordNewPassword(String? password) async {
    emit(state.copyWith(forgotPasswordNewPassword: password));
  }

  void emitForgotPassword() async {
    final forgotPassword =
        await registerRepository.forgotPassword(state.forgotPasswordEmail);
    forgotPassword.fold(
      (error) {
        emit(state.copyWith(
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (forgotPassword) {
        emit(state.copyWith(
          customMessage: forgotPassword.customMessage,
          customMessageEs: forgotPassword.customMessageEs,
        ));
      },
    );
  }

  void emitForgotPasswordOtp() async {
    final forgotPassword =
        await registerRepository.forgotPassword(state.forgotPasswordEmail);
    forgotPassword.fold(
      (error) {
        emit(state.copyWith(
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (forgotPassword) {
        emit(state.copyWith(
          customMessage: forgotPassword.customCode,
          customMessageEs: forgotPassword.customMessageEs,
        ));
      },
    );
  }

  void emitChangePassword() async {
    emit(state.copyWith(formStatusForgotPassword: FormSubmitting()));
    final forgotPassword = await registerRepository.changePassword(
        state.forgotPasswordEmail,
        state.forgotPasswordOtp,
        state.forgotPasswordNewPassword);
    forgotPassword.fold(
      (error) {
        emit(state.copyWith(
          formStatusForgotPassword:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (forgotPassword) {
        emit(state.copyWith(
          formStatusForgotPassword: SubmissionSuccess(),
          customMessage: forgotPassword.customMessage,
          customMessageEs: forgotPassword.customMessageEs,
        ));
      },
    );
  }
}
