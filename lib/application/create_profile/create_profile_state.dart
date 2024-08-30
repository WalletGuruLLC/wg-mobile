part of 'create_profile_cubit.dart';

class CreateProfileState extends Equatable {
  final String token;
  final String firstName;
  final String lastName;
  final String phone;

  final String socialSecurityNumber;
  final String identificationType;
  final String identificationNumber;

  final String country;
  final String stateLocation;
  final String city;
  final String zipCode;
  final String address;

  final FormSubmissionStatus formStatusOne;
  final FormSubmissionStatus formStatusTwo;
  final FormSubmissionStatus formStatusThree;
  final FormSubmissionStatus formStatusFour;
  final String customMessage;
  final String customMessageEs;
  final String customCode;

  const CreateProfileState({
    this.token = '',
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.socialSecurityNumber = '',
    this.identificationType = '',
    this.identificationNumber = '',
    this.country = '',
    this.stateLocation = '',
    this.city = '',
    this.zipCode = '',
    this.address = '',
    this.formStatusOne = const InitialFormStatus(),
    this.formStatusTwo = const InitialFormStatus(),
    this.formStatusThree = const InitialFormStatus(),
    this.formStatusFour = const InitialFormStatus(),
    this.customMessage = '',
    this.customMessageEs = '',
    this.customCode = '',
  });

  CreateProfileState copyWith({
    String? token,
    String? firstName,
    String? lastName,
    String? phone,
    String? socialSecurityNumber,
    String? identificationType,
    String? identificationNumber,
    String? country,
    String? stateLocation,
    String? city,
    String? zipCode,
    String? address,
    FormSubmissionStatus? formStatusOne,
    FormSubmissionStatus? formStatusTwo,
    FormSubmissionStatus? formStatusThree,
    FormSubmissionStatus? formStatusFour,
    String? customMessage,
    String? customMessageEs,
    String? customCode,
  }) =>
      CreateProfileState(
        token: token ?? this.token,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        socialSecurityNumber: socialSecurityNumber ?? this.socialSecurityNumber,
        identificationType: identificationType ?? this.identificationType,
        identificationNumber: identificationNumber ?? this.identificationNumber,
        country: country ?? this.country,
        stateLocation: stateLocation ?? this.stateLocation,
        city: city ?? this.city,
        zipCode: zipCode ?? this.zipCode,
        address: address ?? this.address,
        formStatusOne: formStatusOne ?? this.formStatusOne,
        formStatusTwo: formStatusTwo ?? this.formStatusTwo,
        formStatusThree: formStatusThree ?? this.formStatusThree,
        formStatusFour: formStatusFour ?? this.formStatusFour,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        customCode: customCode ?? this.customCode,
      );

  CreateProfileState initialState() => const CreateProfileState(
        token: '',
        firstName: '',
        lastName: '',
        phone: '',
        socialSecurityNumber: '',
        identificationType: '',
        identificationNumber: '',
        country: '',
        stateLocation: '',
        city: '',
        zipCode: '',
        address: '',
        formStatusOne: InitialFormStatus(),
        formStatusTwo: InitialFormStatus(),
        formStatusThree: InitialFormStatus(),
        formStatusFour: InitialFormStatus(),
        customMessage: '',
        customMessageEs: '',
        customCode: '',
      );

  @override
  List<Object> get props => [
        token,
        firstName,
        lastName,
        phone,
        socialSecurityNumber,
        identificationType,
        identificationNumber,
        country,
        stateLocation,
        city,
        zipCode,
        address,
        formStatusOne,
        formStatusTwo,
        formStatusThree,
        formStatusFour,
        customMessage,
        customMessageEs,
        customCode,
      ];
}
