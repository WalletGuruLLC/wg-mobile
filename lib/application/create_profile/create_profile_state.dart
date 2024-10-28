part of 'create_profile_cubit.dart';

class CreateProfileState extends Equatable {
  final String id;
  final String token;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final dynamic picture;

  final String socialSecurityNumber;
  final String identificationType;
  final String identificationNumber;

  final List<String> countriesCode;
  final List<String> countries;
  final List<String> states;
  final List<String> cities;
  final String countryCode;
  final String country;
  final String stateLocation;
  final String city;
  final String zipCode;
  final String address;
  final String sumSubToken;
  final String sumSubUserId;

  final FormSubmissionStatus formStatusGetToken;
  final FormSubmissionStatus formStatus;
  final FormSubmissionStatus formStatusOne;
  final FormSubmissionStatus formStatusTwo;
  final FormSubmissionStatus formStatusThree;
  final FormSubmissionStatus formStatusFour;
  final String customMessage;
  final String customMessageEs;
  final String customCode;

  const CreateProfileState({
    this.id = '',
    this.token = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.picture = '',
    this.socialSecurityNumber = '',
    this.identificationType = '',
    this.identificationNumber = '',
    this.countriesCode = const [],
    this.countries = const [],
    this.states = const [],
    this.cities = const [],
    this.countryCode = '',
    this.country = '',
    this.stateLocation = '',
    this.city = '',
    this.zipCode = '',
    this.address = '',
    this.formStatus = const InitialFormStatus(),
    this.formStatusOne = const InitialFormStatus(),
    this.formStatusTwo = const InitialFormStatus(),
    this.formStatusThree = const InitialFormStatus(),
    this.formStatusFour = const InitialFormStatus(),
    this.customMessage = '',
    this.customMessageEs = '',
    this.customCode = '',
    this.sumSubToken = '',
    this.sumSubUserId = '',
    this.formStatusGetToken = const InitialFormStatus(),
  });

  CreateProfileState copyWith({
    String? id,
    String? token,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    File? picture,
    String? socialSecurityNumber,
    String? identificationType,
    String? identificationNumber,
    List<String>? countriesCode,
    List<String>? countries,
    List<String>? states,
    List<String>? cities,
    String? countryCode,
    String? country,
    String? stateLocation,
    String? city,
    String? zipCode,
    String? address,
    FormSubmissionStatus? formStatus,
    FormSubmissionStatus? formStatusOne,
    FormSubmissionStatus? formStatusTwo,
    FormSubmissionStatus? formStatusThree,
    FormSubmissionStatus? formStatusFour,
    String? customMessage,
    String? customMessageEs,
    String? customCode,
    String? sumSubToken,
    String? sumSubUserId,
    FormSubmissionStatus? formStatusGetToken,
  }) =>
      CreateProfileState(
        id: id ?? this.id,
        token: token ?? this.token,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        picture: picture ?? this.picture,
        socialSecurityNumber: socialSecurityNumber ?? this.socialSecurityNumber,
        identificationType: identificationType ?? this.identificationType,
        identificationNumber: identificationNumber ?? this.identificationNumber,
        countriesCode: countriesCode ?? this.countriesCode,
        countries: countries ?? this.countries,
        countryCode: countryCode ?? this.countryCode,
        country: country ?? this.country,
        states: states ?? this.states,
        cities: cities ?? this.cities,
        stateLocation: stateLocation ?? this.stateLocation,
        city: city ?? this.city,
        zipCode: zipCode ?? this.zipCode,
        address: address ?? this.address,
        formStatus: formStatus ?? this.formStatus,
        formStatusOne: formStatusOne ?? this.formStatusOne,
        formStatusTwo: formStatusTwo ?? this.formStatusTwo,
        formStatusThree: formStatusThree ?? this.formStatusThree,
        formStatusFour: formStatusFour ?? this.formStatusFour,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        customCode: customCode ?? this.customCode,
        sumSubToken: sumSubToken ?? this.sumSubToken,
        sumSubUserId: sumSubUserId ?? this.sumSubUserId,
        formStatusGetToken: formStatusGetToken ?? this.formStatusGetToken,
      );

  CreateProfileState initialState() => const CreateProfileState(
        id: '',
        token: '',
        email: '',
        firstName: '',
        lastName: '',
        phone: '',
        picture: '',
        socialSecurityNumber: '',
        identificationType: '',
        identificationNumber: '',
        countriesCode: [],
        countries: [],
        states: [],
        cities: [],
        countryCode: '',
        country: '',
        stateLocation: '',
        city: '',
        zipCode: '',
        address: '',
        formStatus: InitialFormStatus(),
        formStatusOne: InitialFormStatus(),
        formStatusTwo: InitialFormStatus(),
        formStatusThree: InitialFormStatus(),
        formStatusFour: InitialFormStatus(),
        customMessage: '',
        customMessageEs: '',
        customCode: '',
        sumSubToken: '',
        sumSubUserId: '',
        formStatusGetToken: InitialFormStatus(),
      );

  @override
  List<Object> get props => [
        id,
        token,
        email,
        firstName,
        lastName,
        phone,
        socialSecurityNumber,
        identificationType,
        identificationNumber,
        countriesCode,
        countries,
        countryCode,
        country,
        states,
        cities,
        stateLocation,
        city,
        zipCode,
        address,
        formStatus,
        formStatusOne,
        formStatusTwo,
        formStatusThree,
        formStatusFour,
        customMessage,
        customMessageEs,
        customCode,
        picture,
        sumSubToken,
        sumSubUserId,
        formStatusGetToken,
      ];
}
