import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  List<String> itemsMock = ['item1', 'item2', 'item3'];
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
    _loadCountries();
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
          CountryForm(
              items: countriesNames,
              onChanged: (value) {
                setState(() {
                  selectedCountry = value!;
                  if (selectedCountry != null) {
                    // _loadStates(selectedCountry: selectedCountry!);
                  }
                });
              }),
          const SizedBox(height: 20),
          FormLabel(label: l10n.state),
          StateForm(
            enabled: selectedCountry == null ? false : true,
            items: itemsMock,
            onChanged: (value) {
              setState(() {
                selectedState = 'Meta';
                if (selectedState != null && selectedCountry != null) {
                  _loadCities(
                      selectedState: selectedState!,
                      selectedCountry: selectedCountry!);
                }
              });
            },
          ),
          const SizedBox(height: 20),
          FormLabel(label: l10n.city),
          CityForm(
              items: cities,
              onChanged: (value) {
                if (selectedState != null) {
                  _loadStates(selectedCountry: selectedCountry!);
                }
              }),
          const SizedBox(height: 20),
          FormLabel(label: l10n.zipCode),
          ZipCodeForm(onChanged: _onFormChanged),
          const SizedBox(height: 20),
          FormLabel(label: l10n.address),
          AddressForm(onChanged: _onFormChanged),
          SizedBox(height: size * 0.05),
          CreateProfileButtons(onPressed1: () {}, onPressed2: () {}),
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
  }
}
