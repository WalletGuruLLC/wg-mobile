import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/domain/core/entities/wallet_entity.dart';
import 'package:wallet_guru/domain/user/repositories/user_repository.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository = Injector.resolve<UserRepository>();

  UserCubit() : super(const UserState());

  void emitGetUserInformation() async {
    final registerResponse = await userRepository.getCurrentUserInformation();

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
    String? phoneCode,
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
      phoneCode: phoneCode,
    );

    emit(state.copyWith(user: updatedUser, userHasChanged: true));
  }

  Map<String, dynamic> getChangedFields() {
    final currentUserMap = state.user?.toMap();
    final initialUserMap = state.initialUser?.toMap();
    Map<String, dynamic> changes = {};

    if (currentUserMap != null && initialUserMap != null) {
      currentUserMap.forEach((key, value) {
        if (value != initialUserMap[key]) {
          if (key == 'phone' || key == 'phoneCode') {
            // Combinar phone y phoneCode en un solo campo phone
            final combinedPhone =
                '${state.user?.phoneCode}-${state.user?.phone}';
            changes['phone'] = combinedPhone;
          } else {
            changes[key] = value;
          }
        }
      });
    }

    return changes;
  }

  Future<void> submitUserChanges() async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    final changedFields = getChangedFields();
    if (changedFields.isNotEmpty) {
      final updatedUser = await userRepository.updateUserInformation(
          changedFields, state.user!.id);
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

  void setCurrentPassword(String? password) {
    emit(state.copyWith(currentPassword: password));
  }

  void setNewPassword(String? password) {
    emit(state.copyWith(newPassword: password));
  }

  void setConfirmNewPassword(String? password) {
    emit(state.copyWith(confirmNewPassword: password));
  }

  void validatePasswords() {
    bool isSubmittable = state.currentPassword.isNotEmpty == true &&
        state.newPassword.isNotEmpty == true &&
        state.confirmNewPassword == state.newPassword;

    if (isSubmittable) {
      emit(state.copyWith(isSubmittable: true));
    } else {
      emit(state.copyWith(isSubmittable: false));
    }
  }

  Future<void> emitChangePassword() async {
    final updatedUser = await userRepository.changePassword(
        state.user!.email, state.currentPassword, state.newPassword);
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
          customCode: updatedUser.customCode,
          customMessage: updatedUser.customMessage,
          customMessageEs: updatedUser.customMessageEs,
        ));
      },
    );
  }

  void resetInitialUser() {
    emit(state.copyWith(
      userHasChanged: false,
      user: state.initialUser,
    ));
  }

  void emitGetWalletInformation() async {
    final updatedUser = await userRepository.getWalletInformation();
    updatedUser.fold(
      (error) {
        emit(state.copyWith(
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (updatedUser) {
        emit(state.copyWith(
            wallet: WalletEntity.fromWallet(updatedUser.data!.wallet!)));
      },
    );
  }

  void emitLockAccount() async {
    emit(
      state.copyWith(formStatusLockAccount: FormSubmitting()),
    );
    final updatedUser = await userRepository.lockAccount(state.wallet!.id);
    updatedUser.fold(
      (error) {
        emit(state.copyWith(
          formStatusLockAccount:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (updatedUser) {
        emit(state.copyWith(
          formStatusLockAccount: SubmissionSuccess(),
          customCode: updatedUser.customCode,
          customMessage: updatedUser.customMessage,
          customMessageEs: updatedUser.customMessageEs,
        ));
      },
    );
  }

  void resetFormStatusLockAccount() {
    emit(state.copyWith(formStatusLockAccount: const InitialFormStatus()));
  }

  void submitUserPicture(String? picture) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
  }
}
