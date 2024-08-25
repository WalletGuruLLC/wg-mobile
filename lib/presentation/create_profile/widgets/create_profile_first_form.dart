import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/first_name_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/last_name_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/phone_number_form.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';

class CreateProfileFirstForm extends StatefulWidget {
  const CreateProfileFirstForm({super.key});

  @override
  State<CreateProfileFirstForm> createState() => CreateProfileFirstFormState();
}

class CreateProfileFirstFormState extends State<CreateProfileFirstForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';

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
          PhoneNumberForm(
            initialValue: _phoneNumber,
            onChanged: (value) => _onFormChanged('phoneNumber', value),
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
          break;
        case 'lastName':
          _lastName = value!;
          break;
        case 'phoneNumber':
          _phoneNumber = value!;
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
      // Form is valid, proceed with further actions
      debugPrint('Form is valid');
      GoRouter.of(context).pushNamed(Routes.createProfile2.name);
    } else {
      // Form is invalid, show errors
      debugPrint('Form is invalid');
    }
  }
}
