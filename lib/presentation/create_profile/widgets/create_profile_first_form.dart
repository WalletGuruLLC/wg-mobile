import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/last_name_form.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/first_name_form.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/phone_number_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/country_code_form.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';

class CreateProfileFirstForm extends StatefulWidget {
  const CreateProfileFirstForm({
    super.key,
    required this.id,
    required this.email,
  });

  final String id;
  final String email;

  @override
  State<CreateProfileFirstForm> createState() => CreateProfileFirstFormState();
}

class CreateProfileFirstFormState extends State<CreateProfileFirstForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  late CreateProfileCubit createProfileCubit;

  @override
  void initState() {
    BlocProvider.of<LoginCubit>(context).initialStatus();
    BlocProvider.of<RegisterCubit>(context).initialStatus();
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
    createProfileCubit.setUserId(widget.id, widget.email);
    createProfileCubit.loadCountryCodeAndCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: _buildProfileBasicInfoView(
        size,
        context,
        l10n,
      ),
    );
  }

  Widget _buildProfileBasicInfoView(
      double size, BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const UserProfileDescription(),
          const ProgressBar(currentStep: 1),
          SizedBox(height: size * 0.030),
          FormLabel(label: l10n.firstName),
          FirstNameForm(
            initialValue: _firstName,
            onChanged: (value) => _onFormChanged('firstName', value),
          ),
          const SizedBox(height: 30),
          FormLabel(label: l10n.lastName),
          LastNameForm(
            initialValue: _lastName,
            onChanged: (value) => _onFormChanged('lastName', value),
          ),
          const SizedBox(height: 30),
          FormLabel(label: l10n.phoneNumber),
          SizedBox(
            width: size * 0.8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<CreateProfileCubit, CreateProfileState>(
                  builder: (context, state) {
                    return CountryCodeForm(
                      items: state.countries,
                      onChanged: (value) {
                        if (value != null) {
                          createProfileCubit.selectCountryCode(value);
                        }
                      },
                    );
                  },
                ),
                Expanded(
                  child: PhoneNumberForm(
                    initialValue: _phoneNumber,
                    onChanged: (value) => _onFormChanged('phoneNumber', value),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size * 0.12),
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
        case 'firstName':
          _firstName = value!;
          createProfileCubit.setUserFirstName(_firstName);
          break;
        case 'lastName':
          _lastName = value!;
          createProfileCubit.setUserLastName(_lastName);
          break;
        case 'phoneNumber':
          _phoneNumber = value!;
          createProfileCubit.setUserPhone(_phoneNumber);
          break;
      }
    });
  }

  void _onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  // Method to handle button actions
  void _onNextButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      GoRouter.of(context).pushNamed(Routes.createProfile2.name);
    }
  }
}
