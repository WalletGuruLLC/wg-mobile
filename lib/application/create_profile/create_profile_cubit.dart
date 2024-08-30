import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/domain/create_profile/entities/create_profile_two_entity.dart';
import 'package:wallet_guru/domain/create_profile/entities/create_profile_one_entity.dart';
import 'package:wallet_guru/domain/create_profile/entities/create_profile_three_entity.dart';
import 'package:wallet_guru/domain/create_profile/repositories/create_profile_repository.dart';

part 'create_profile_state.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  CreateProfileCubit() : super(const CreateProfileState());
  final createProfileRepository = Injector.resolve<CreateProfileRepository>();

  void emitCreateProfileOne() async {
    emit(
      state.copyWith(formStatusOne: FormSubmitting()),
    );
    final createProfile1 =
        await createProfileRepository.updateUser(CreateProfileOneEntity(
      id: '0827202450694263WU',
      firstName: state.firstName,
      lastName: state.lastName,
      phone: state.phone,
      termsConditions: true,
      privacyPolicy: true,
    ));
    createProfile1.fold(
      (error) {
        emit(state.copyWith(
          formStatusOne:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (createProfileOne) {
        emit(state.copyWith(
          customMessage: createProfileOne.customCode,
          customMessageEs: createProfileOne.customMessageEs,
          formStatusOne: SubmissionSuccess(),
        ));
      },
    );
  }

  void setUserFirstName(String? firstName) async {
    emit(state.copyWith(firstName: firstName));
  }

  void setUserLastName(String? lastName) async {
    emit(state.copyWith(lastName: lastName));
  }

  void setUserPhone(String? phone) async {
    emit(state.copyWith(phone: phone));
  }

  void cleanFormStatusOne() async {
    emit(state.copyWith(formStatusOne: const InitialFormStatus()));
  }

  void emitCreateProfileTwo() async {
    emit(
      state.copyWith(formStatusTwo: FormSubmitting()),
    );
    final createProfile2 =
        await createProfileRepository.updateUser(CreateProfileTwoEntity(
      id: '',
      socialSecurityNumber: state.socialSecurityNumber,
      identificationType: state.identificationType,
      identificationNumber: state.identificationNumber,
    ));
    createProfile2.fold(
      (error) {
        emit(state.copyWith(
          formStatusTwo:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (createProfileTwo) {
        emit(state.copyWith(
          customMessage: createProfileTwo.customCode,
          customMessageEs: createProfileTwo.customMessageEs,
          formStatusTwo: SubmissionSuccess(),
        ));
      },
    );
  }

  void setSocialSecurityNumber(String? socialSecurityNumber) async {
    emit(state.copyWith(socialSecurityNumber: socialSecurityNumber));
  }

  void setIdentificationType(String? identificationType) async {
    emit(state.copyWith(identificationType: identificationType));
  }

  void setIdentificationNumber(String? identificationNumber) async {
    emit(state.copyWith(identificationNumber: identificationNumber));
  }

  void cleanFormStatusTwo() async {
    emit(state.copyWith(formStatusTwo: const InitialFormStatus()));
  }

  void emitCreateProfileThree() async {
    emit(
      state.copyWith(formStatusThree: FormSubmitting()),
    );
    final createProfile2 =
        await createProfileRepository.updateUser(CreateProfileThreeEntity(
      id: '',
      country: state.country,
      stateLocation: state.stateLocation,
      city: state.city,
      zipCode: state.zipCode,
      address: state.address,
    ));
    createProfile2.fold(
      (error) {
        emit(state.copyWith(
          formStatusThree:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (createProfileTwo) {
        emit(state.copyWith(
          customMessage: createProfileTwo.customCode,
          customMessageEs: createProfileTwo.customMessageEs,
          formStatusThree: SubmissionSuccess(),
        ));
      },
    );
  }

  void cleanFormStatusThree() async {
    emit(state.copyWith(formStatusThree: const InitialFormStatus()));
  }
}
