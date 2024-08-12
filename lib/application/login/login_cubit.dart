import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/domain/login/repositories/login_repository.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  final registerRepository = Injector.resolve<LoginRepository>();

  void emitSignInUser(UserEntity userEntity) async {
    emit(
      state.copyWith(
        formStatus: FormSubmitting(),
        email: userEntity.email,
      ),
    );
    final verifyEmailOtp = await registerRepository.signInUser(userEntity);
    verifyEmailOtp.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.message)),
        ));
      },
      (singInUser) {
        emit(state.copyWith(
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }
}
