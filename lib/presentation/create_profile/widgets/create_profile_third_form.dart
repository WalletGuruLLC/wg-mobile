import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/city_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/state_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/country_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/address_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/zip_code_form.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';

class CreateProfileThirdForm extends StatefulWidget {
  const CreateProfileThirdForm({super.key});

  @override
  State<CreateProfileThirdForm> createState() => CreateProfileThirdFormState();
}

class CreateProfileThirdFormState extends State<CreateProfileThirdForm> {
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
              return StateForm(
                enabled: state.country.isNotEmpty,
                items: state.states.isNotEmpty ? state.states : [''],
                onChanged: (value) {
                  if (value != null) {
                    createProfileCubit.selectState(value);
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
                items: state.cities.isNotEmpty ? state.cities : [''],
                onChanged: (value) {
                  if (value != null) {
                    createProfileCubit.selectCity(value);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 20),
          FormLabel(label: l10n.zipCode),
          ZipCodeForm(onChanged: (value) => _onFormChanged('zipCode', value)),
          const SizedBox(height: 20),
          FormLabel(label: l10n.address),
          AddressForm(onChanged: (value) => _onFormChanged('address', value)),
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
      GoRouter.of(context).pushNamed(Routes.createProfile4.name);
    }
  }
}
