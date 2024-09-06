// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/city_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/phone_number_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/state_form.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_header.dart';

import '../../core/styles/schemas/app_color_schema.dart';
import '../../core/widgets/forms/address_form.dart';
import '../../core/widgets/forms/country_code_form.dart';
import '../../core/widgets/forms/country_form.dart';
import '../../core/widgets/forms/form_label.dart';
import '../../core/widgets/forms/zip_code_form.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showAppBar: true,
      showBottomNavigationBar: true,
      pageAppBarTitle: 'My info',
      children: [
        SizedBox(
          width: size.width * 0.90,
          height: size.height,
          child: const MyInfoForm(),
        ),
      ],
    );
  }
}

class MyInfoForm extends StatefulWidget {
  const MyInfoForm({super.key});

  @override
  State<MyInfoForm> createState() => _MyInfoFormState();
}

class _MyInfoFormState extends State<MyInfoForm> {
  final _formKey = GlobalKey<FormState>();
  late CreateProfileCubit createProfileCubit;
  String nameHC = 'John Doe';
  String phoneNumberHC = '4383624400';
  String imgURLHC =
      'https://pbs.twimg.com/profile_images/725013638411489280/4wx8EcIA_400x400.jpg';
  String zipCodeHC = '75869';
  String addressHC = 'FalseStreet 123 ouest';
  String countryHC = 'Colombia';
  String stateLocationHC = 'Antioquia';
  String cityHC = 'Medellín';

  bool readOnly = true;
  bool hasValuesChanged = false;

  String? currentPhoneNumber;
  String? currentZipCode;
  String? currentAddress;
  String? currentCountry;
  String? currentStateLocation;
  String? currentCity;

  @override
  void initState() {
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
    createProfileCubit.loadCountryCodeAndCountry();
    currentPhoneNumber = phoneNumberHC;
    currentZipCode = zipCodeHC;
    currentAddress = addressHC;
    currentCountry = countryHC;
    currentStateLocation = stateLocationHC;
    currentCity = cityHC;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: _buildMyInfoForm(size, l10n),
    );
  }

  Widget _buildMyInfoForm(
    double size,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeaderWidget(name: nameHC, avatarImage: imgURLHC),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.phoneNumber),
        Row(
          children: [
            BlocBuilder<CreateProfileCubit, CreateProfileState>(
              builder: (context, state) {
                final uniqueCountriesCode =
                    state.countriesCode.toSet().toList();
                return CountryCodeForm(
                  items: uniqueCountriesCode,
                  onChanged: (value) {
                    if (value != null) {
                      createProfileCubit.selectCountryCode(value);
                      _checkValuesChanged();
                    }
                  },
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: PhoneNumberForm(
                  readOnly: readOnly,
                  initialValue: phoneNumberHC,
                  onChanged: (value) {
                    currentPhoneNumber = value;
                    _checkValuesChanged();
                  },
                  fieldActivatorWidget: _buildFieldActivatorWidget(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.country),
        BlocBuilder<CreateProfileCubit, CreateProfileState>(
          builder: (context, state) {
            return CountryForm(
              initialValue: currentCountry,
              items: state.countries,
              onChanged: (value) {
                if (value != null) {
                  currentCountry = value;
                  currentStateLocation = null;
                  createProfileCubit.selectCountry(value);
                  _checkValuesChanged();
                }
              },
            );
          },
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.state),
        BlocBuilder<CreateProfileCubit, CreateProfileState>(
          builder: (context, state) {
            return StateForm(
              initialValue: currentStateLocation,
              enabled: state.country.isNotEmpty,
              items: state.states.isNotEmpty ? state.states : [''],
              onChanged: (value) {
                if (value != null) {
                  currentStateLocation = value;
                  currentCity = null;
                  createProfileCubit.selectState(value);
                  _checkValuesChanged();
                }
              },
            );
          },
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.city),
        BlocBuilder<CreateProfileCubit, CreateProfileState>(
          builder: (context, state) {
            return CityForm(
              initialValue: currentCity,
              enabled: state.stateLocation.isNotEmpty,
              items: state.cities.isNotEmpty ? state.cities : [''],
              onChanged: (value) {
                if (value != null) {
                  currentCity = value;
                  createProfileCubit.selectCity(value);
                  _checkValuesChanged();
                }
              },
            );
          },
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.zipCode),
        ZipCodeForm(
          readOnly: readOnly,
          initialValue: zipCodeHC,
          onChanged: (value) {
            currentZipCode = value;
            _checkValuesChanged();
          },
          fieldActivatorWidget: _buildFieldActivatorWidget(),
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.address),
        AddressForm(
          readOnly: readOnly,
          initialValue: addressHC,
          onChanged: (value) {
            currentAddress = value;
            _checkValuesChanged();
          },
          fieldActivatorWidget: _buildFieldActivatorWidget(),
        ),
        SizedBox(height: size * 0.025),
        _buildSaveButton(hasValuesChanged),
      ],
    );
  }

  Widget _buildFieldActivatorWidget() {
    return ActivatorFieldWidget(
      onTap: () {
        if (readOnly) {
          setState(() {
            readOnly = !readOnly;
          });
        }
      },
    );
  }

  void _checkValuesChanged() {
    if (currentPhoneNumber != phoneNumberHC ||
        currentZipCode != zipCodeHC ||
        currentAddress != addressHC ||
        currentCountry != countryHC ||
        currentStateLocation != stateLocationHC ||
        currentCity != cityHC) {
      setState(() {
        hasValuesChanged = true;
      });
    }
  }

  Widget _buildSaveButton(
    bool hasValuesChanged,
  ) {
    return CustomButton(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      borderRadius: 12,
      color: hasValuesChanged
          ? AppColorSchema.of(context).buttonColor
          : Colors.transparent,
      border: Border.all(
          width: hasValuesChanged ? 0 : .75,
          color: hasValuesChanged ? Colors.transparent : Colors.white),
      text: 'Save',
      onPressed: () {
        print(currentCountry);
      },
    );
  }
}

class ActivatorFieldWidget extends StatelessWidget {
  final void Function()? onTap;
  const ActivatorFieldWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
