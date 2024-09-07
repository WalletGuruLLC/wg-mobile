import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/user/repositories/user_repository.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository = Injector.resolve<UserRepository>();

  UserCubit() : super(const UserState());

  void emitGetUserInformation() async {
    final registerResponse =
        await userRepository.getCurrentUserInformation(state.userId);

    registerResponse.fold(
      (error) {
        emit(state.copyWith(
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (registerResponse) {
        final user = UserEntity.fromUser(registerResponse.data!.user!);
        emit(state.copyWith(
          user: user,
          initialUser: user,
        ));
      },
    );
  }

  void setUserId(String? userId) {
    emit(state.copyWith(userId: userId));
  }

  void setUser(User user) {
    emit(state.copyWith(
      user: UserEntity.fromUser(user),
      initialUser: UserEntity.fromUser(user),
      userId: user.id,
    ));
  }

  void updateUser({
    String? email,
    String? phone,
    String? address,
    String? city,
    String? country,
    String? zipCode,
    String? stateLocation,
    String? lastName,
    String? firstName,
    bool? active,
  }) {
    final updatedUser = state.user?.copyWith(
      email: email,
      phone: phone,
      address: address,
      city: city,
      country: country,
      zipCode: zipCode,
      stateLocation: stateLocation,
      lastName: lastName,
      firstName: firstName,
      active: active,
    );

    emit(state.copyWith(user: updatedUser, userHasChanged: true));
  }

  // Obtener los campos modificados
  Map<String, dynamic> getChangedFields() {
    final currentUserMap = state.user?.toMap();
    final initialUserMap = state.initialUser?.toMap();
    Map<String, dynamic> changes = {};

    if (currentUserMap != null && initialUserMap != null) {
      currentUserMap.forEach((key, value) {
        if (value != initialUserMap[key]) {
          changes[key] = value;
        }
      });
    }

    return changes;
  }

  // Enviar los cambios detectados al backend
  Future<void> submitUserChanges() async {
    final changedFields = getChangedFields();
    if (changedFields.isNotEmpty) {
      final updatedUser = await userRepository.updateUserInformation(
          changedFields, state.userId);
      updatedUser.fold(
        (error) {
          emit(state.copyWith(
            formStatus: SubmissionFailed(exception: Exception(error.messageEn)),
            customCode: error.code,
            customMessage: error.messageEn,
            customMessageEs: error.messageEs,
          ));
        },
        (updatedUser) {
          emit(state.copyWith(
            formStatus: SubmissionSuccess(),
            userHasChanged: false,
          ));
        },
      );
    }
  }

  void resetFormStatus() {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
  }
}
