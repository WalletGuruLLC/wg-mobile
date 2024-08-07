import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/domain/register/repositories/register_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  final RegisterRepository registerRepository = RegisterRepository();

  void emitUserCreate(UserEntity userEntity) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    final verifyEmailOtp = await registerRepository.creationUser(userEntity);
    verifyEmailOtp.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.message)),
        ));
      },
      (createUser) {
        emit(state.copyWith(
          id: createUser.id,
          email: createUser.email,
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }
}
