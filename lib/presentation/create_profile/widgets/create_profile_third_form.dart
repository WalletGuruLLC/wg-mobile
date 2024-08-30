import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/domain/core/models/country_model.dart';

import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/address_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/city_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/country_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/state_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/zip_code_form.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';

class CreateProfileThirdForm extends StatefulWidget {
  const CreateProfileThirdForm({super.key});

  @override
  State<CreateProfileThirdForm> createState() => CreateProfileThirdFormState();
}

class CreateProfileThirdFormState extends State<CreateProfileThirdForm> {
  final _formKey = GlobalKey<FormState>();
  String _address = '';
  bool _addressMinLength = false;
  
  late List<Country> countries;
  late List<LocationState> locationStates;
  List<String> cities = [];

  List<String> countriesNames = [];
  List<String> statesNames = [];

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    //_loadCountries();
    context.read<CreateProfileCubit>().loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    return Form(
        key: _formKey,
        child: _buildProfilePersonalInfoView(size, context, l10n));
  }

  Widget _buildProfilePersonalInfoView(
      double size, BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserProfileDescription(),
          const ProgressBar(currentStep: 3),
          SizedBox(height: size * 0.030),
          FormLabel(label: l10n.country),
          BlocBuilder<CreateProfileCubit, CreateProfileState>(
            builder: (context, state) {
              return CountryForm(
                items: state.countries,
                onChanged: (value) {
                  if (value != null) {
                    context.read<CreateProfileCubit>().selectCountry(value);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 20),
          FormLabel(label: l10n.state),
          BlocBuilder<CreateProfileCubit, CreateProfileState>(
            builder: (context, state) {
              return StateForm(
                enabled: state.country.isNotEmpty,
                items: state.states,
                onChanged: (value) {
                  if (value != null) {
                    context.read<CreateProfileCubit>().selectState(value);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 20),
          FormLabel(label: l10n.city),
          BlocBuilder<CreateProfileCubit, CreateProfileState>(
            builder: (context, state) {
              return CityForm(
                items: state.cities,
                onChanged: (value) {
                  if (value != null) {
                    context.read<CreateProfileCubit>().selectCity(value);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 20),
          FormLabel(label: l10n.zipCode),
          ZipCodeForm(onChanged: _onFormChanged),
          const SizedBox(height: 20),
          FormLabel(label: l10n.address),
          AddressForm(onChanged: _onFormChanged),
          SizedBox(height: size * 0.05),
          CreateProfileButtons(
              onPressed1: () {},
              onPressed2: () {
                //validar que el formulario este llenado y mandarlo a la siguiente vista
              }),
        ],
      ),
    );
  }

  // Method to handle form changes
  void _onFormChanged(String? value) {
    setState(() {
      _address = value!;
      _addressMinLength = value.length > 4;
    });
  }

  // Method to handle button actions
  void _onButtonPressed() {
    if (_formKey.currentState!.validate() && _addressMinLength) {
      _formKey.currentState!.reset();
      setState(() {
        _address = '';
        _addressMinLength = false;
      });
      _buildSuccessfulModal();
    }
  }

  // Method to build the successful modal
  Future<dynamic> _buildSuccessfulModal() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = AppLocalizations.of(context)!;
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          content: Column(
            children: [
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.walletSuccessMessage,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.continueCheckingProfile,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
        );
      },
    );
  }
/*
  Future<void> _loadCountries() async {
    CountriesDataSource countriesDataSource = CountriesDataSource();
    countries = await countriesDataSource.getCountriesList();
    for (Country country in countries) {
      countriesNames.add(country.name);
    }
    setState(() {});
  }

  Future<void> _loadStates({required String selectedCountry}) async {
    StateDataSource stateDataSource = StateDataSource();
    locationStates =
        await stateDataSource.getStates(countryName: selectedCountry);
    for (LocationState state in locationStates) {
      statesNames.add(state.name);
    }
    print(statesNames);
    setState(() {});
  }

  Future<void> _loadCities(
      {required String selectedState, required String selectedCountry}) async {
    CitiesDataSource citiesDataSource = CitiesDataSource();
    cities = await citiesDataSource.getCitites(
      stateName: selectedState,
      countryName: selectedCountry,
    );
    print(cities);
    setState(() {});
  }*/
}
