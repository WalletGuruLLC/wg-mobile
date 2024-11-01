import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/address_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/zip_code_form.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/city_form_auto_complete.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/country_form_auto_complete.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/state_form_auto_complete.dart';

class CreateProfile2Form extends StatefulWidget {
  final String? id;
  final String? email;
  const CreateProfile2Form({super.key, this.id, this.email});

  @override
  State<CreateProfile2Form> createState() => CreateProfile2FormState();
}

class CreateProfile2FormState extends State<CreateProfile2Form> {
  final _formKey = GlobalKey<FormState>();
  String _address = '';
  String _zipCode = '';
  bool _addressMinLength = false;
  late CreateProfileCubit createProfileCubit;

  @override
  void initState() {
    super.initState();
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
    createProfileCubit.loadCountries();
    if (widget.email != null &&
        widget.id != null &&
        widget.email!.isNotEmpty &&
        widget.id!.isNotEmpty) {
      createProfileCubit.setUserId(widget.id!, widget.email!);
    }
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
          const ProgressBar(currentStep: 2),
          SizedBox(height: size * 0.030),
          FormLabel(label: l10n.country),
          BlocBuilder<CreateProfileCubit, CreateProfileState>(
            builder: (context, state) {
              List<String> countries = List.from(state.countries);
              if (countries.contains('United States')) {
                countries.remove('United States');
                countries.insert(0, 'United States');
              }
              return CountryFormAutoComplete(
                readOnly: false,
                initialValue: state.country.isNotEmpty ? state.country : null,
                onChanged: (value) {
                  if (value != null) {
                    createProfileCubit.selectCountry(value);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 20),
          FormLabel(label: l10n.state),
          BlocBuilder<CreateProfileCubit, CreateProfileState>(
            builder: (context, state) {
              return StateFormAutoComplete(
                readOnly: false,
                initialValue:
                    state.stateLocation.isNotEmpty ? state.stateLocation : '',
                onChanged: (value) {
                  createProfileCubit.selectState(value);
                },
              );
            },
          ),
          const SizedBox(height: 20),
          FormLabel(label: l10n.city),
          BlocBuilder<CreateProfileCubit, CreateProfileState>(
            builder: (context, state) {
              return CityFormAutocomplete(
                readOnly: false,
                initialValue: state.city.isNotEmpty ? state.city : '',
                onChanged: (value) {
                  createProfileCubit.selectCity(value!);
                },
              );
            },
          ),
          const SizedBox(height: 20),
          FormLabel(label: l10n.zipCode),
          ZipCodeForm(
            initialValue: createProfileCubit.state.zipCode.isNotEmpty
                ? createProfileCubit.state.zipCode
                : null,
            onChanged: (value) => _onFormChanged('zipCode', value),
          ),
          const SizedBox(height: 20),
          FormLabel(label: l10n.address),
          AddressForm(
            initialValue: createProfileCubit.state.address.isNotEmpty
                ? createProfileCubit.state.address
                : null,
            onChanged: (value) => _onFormChanged('address', value),
          ),
          SizedBox(height: size * 0.05),
          CreateProfileButtons(
            onPressed1: _onBackButtonPressed,
            onPressed2: _onNextButtonPressed,
          ),
        ],
      ),
    );
  }

  void _onFormChanged(String formType, String? value) {
    setState(() {
      switch (formType) {
        case 'zipCode':
          _zipCode = value!;
          createProfileCubit.setZipCode(_zipCode);
          break;
        case 'address':
          _address = value!;
          _addressMinLength = value.length > 4;
          createProfileCubit.setAddress(_address);
          break;
      }
    });
  }

  void _onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  // Method to handle button actions
  void _onNextButtonPressed() {
    if (_formKey.currentState?.validate() ?? _addressMinLength) {
      debugPrint('Form is valid');
      createProfileCubit.emitCreateProfileOne();
    }
  }
}
