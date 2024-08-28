import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/domain/register/repositories/register_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());
  final registerRepository = Injector.resolve<RegisterRepository>();

  void emitUserCreate() async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    final registerResponse = await registerRepository.creationUser(
      state.email,
      state.passwordHash,
    );
    registerResponse.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (createUser) {
        emit(state.copyWith(
          email: state.email,
          passwordHash: state.passwordHash,
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }

  void setSignUpEmail(String? email) async {
    emit(state.copyWith(email: email));
  }

  void setUserPassword(String? password) async {
    emit(state.copyWith(passwordHash: password));
  }

  void cleanFormStatus() async {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
  }
}
