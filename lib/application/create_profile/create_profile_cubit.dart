import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/domain/core/models/country_model.dart';
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
  final countriesDataSource = CountriesDataSource();
  final stateDataSource = StateDataSource();
  final citiesDataSource = CitiesDataSource();

  // Cargar los países
  Future<void> loadCountryCodeAndCountry() async {
    final countries = await countriesDataSource.getCountriesList();
    emit(
      state.copyWith(
        countries: countries.map((c) => c.name).toList(),
        countriesCode: countries.map((c) => c.dialCode).toList(),
      ),
    );
  }

  Future<void> selectCountryCode(String countryCode) async {
    emit(state.copyWith(countryCode: countryCode));
  }

  // Cargar los países
  Future<void> loadCountries() async {
    final countries = await countriesDataSource.getCountriesList();
    emit(state.copyWith(
      countries: countries.map((c) => c.name).toList(),
      states: [],
      cities: [],
    ));
  }

  // Manejar la selección del país y cargar los estados correspondientes
  Future<void> selectCountry(String country) async {
    emit(state.copyWith(country: country, states: [], cities: []));
    final states = await stateDataSource.getStates(countryName: country);
    emit(state.copyWith(
      states: states.map((s) => s.name).toList(),
      cities: [],
    ));
  }

  // Manejar la selección del estado y cargar las ciudades correspondientes
  Future<void> selectState(String stateLocation) async {
    emit(state.copyWith(stateLocation: stateLocation, cities: []));
    final cities = await citiesDataSource.getCities(
      stateName: stateLocation,
      countryName: state.country,
    );
    emit(state.copyWith(cities: cities));
  }

  // Manejar la selección de la ciudad
  void selectCity(String city) {
    emit(state.copyWith(city: city));
  }

  void setUserId(String? id, String? email) async {
    emit(state.copyWith(
      id: id,
      email: email,
    ));
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

  void setProfilePicture(File? picture) async {
    emit(state.copyWith(picture: picture));
  }

  void emitCreateProfileTwo() async {
    emit(
      state.copyWith(formStatusTwo: FormSubmitting()),
    );
    final createProfile2 =
        await createProfileRepository.updateUser(CreateProfileTwoEntity(
      id: state.id,
      email: state.email,
      phone: "${state.countryCode}-${state.phone}",
      socialSecurityNumber: state.socialSecurityNumber,
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

  void setDateOfBirth(String? dateOfBirth) async {
    emit(state.copyWith(dateOfBirth: dateOfBirth));
  }

  void cleanFormStatusTwo() async {
    emit(state.copyWith(formStatusTwo: const InitialFormStatus()));
  }

  void emitCreateProfileThree() async {
    emit(
      state.copyWith(formStatusThree: FormSubmitting()),
    );
    if (state.picture != null && state.picture != '') {
      await submitUserPicture(state.picture!, state.id);
    }

    final createProfile3 =
        await createProfileRepository.updateUser(CreateProfileThreeEntity(
      id: state.id,
      email: state.email,
      dateOfBirth: DateTime.parse(state.dateOfBirth),
    ));
    createProfile3.fold(
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

  // Update user profile specifically location information
  void emitCreateProfileOne() async {
    emit(
      state.copyWith(formStatusOne: FormSubmitting()),
    );
    final createProfile1 =
        await createProfileRepository.updateUser(CreateProfileOneEntity(
      id: state.id,
      email: state.email,
      country: state.country,
      stateLocation: state.stateLocation,
      city: state.city,
      zipCode: state.zipCode,
      address: state.address,
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

  void cleanFormStatusThree() async {
    emit(state.copyWith(formStatusThree: const InitialFormStatus()));
  }

  void cleanFormStatus() async {
    emit(state.copyWith(formStatus: const InitialFormStatus()));
  }

  void setZipCode(String? zipCode) async {
    emit(state.copyWith(zipCode: zipCode));
  }

  void setAddress(String? address) async {
    emit(state.copyWith(address: address));
  }

  void emitInitialStatus() async {
    emit(state.initialState());
  }

  Future<void> submitUserPicture(File picture, String userId) async {
    final updatedUser =
        await createProfileRepository.updateUserPicture(picture, userId);
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
          customCode: updatedUser.customCode,
          customMessage: updatedUser.customMessage,
          customMessageEs: updatedUser.customMessageEs,
        ));
      },
    );
  }

  void updateUserPicture(File picture) async {
    emit(state.copyWith(picture: picture));
  }

  void generateSumSubAccessToken(String userId) async {
    emit(state.copyWith(formStatusGetToken: FormSubmitting()));
    final generatedToken =
        await createProfileRepository.generateSumSubAccessToken(userId);
    generatedToken.fold(
      (error) {
        emit(state.copyWith(
          formStatusGetToken:
              SubmissionFailed(exception: Exception(error.messageEn)),
        ));
      },
      (generatedToken) {
        emit(state.copyWith(
          formStatusGetToken: SubmissionSuccess(),
          sumSubToken: generatedToken.sumSubToken,
          sumSubUserId: generatedToken.sumSubUserId,
        ));
      },
    );
  }
}
