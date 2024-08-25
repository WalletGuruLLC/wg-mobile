import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/dropdown_base.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/identification_number_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/identification_type_drop_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/social_security_form.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';

class CreateProfileSecondForm extends StatefulWidget {
  const CreateProfileSecondForm({super.key});

  @override
  State<CreateProfileSecondForm> createState() =>
      CreateProfileSecondFormState();
}

class CreateProfileSecondFormState extends State<CreateProfileSecondForm> {
  final _formKey = GlobalKey<FormState>();
  String _ssn = '';
  String _identificationNumber = '';
  String _idType = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    return Form(
        key: _formKey, child: _buildProfileLocationView(size, context, l10n));
  }

  Widget _buildProfileLocationView(
      double size, BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const UserProfileDescription(),
          const ProgressBar(currentStep: 2),
          SizedBox(height: size * 0.030),
          FormLabel(label: l10n.socialSecurityNumber),
          SocialSecurityForm(
            initialValue: _ssn,
            onChanged: (value) => _onFormChanged('snn', value),
          ),
          const SizedBox(height: 30),
          const FormLabel(label: 'Identification Type'),
          IdentificationTypeDropForm(
            // initialValue: 'item1',
            hintText: 'Select you ID type',
            items: const ['item1', 'item2', 'item3'],
            onChanged: (value) {},
          ),
          const SizedBox(height: 30),
          FormLabel(label: l10n.identificationNumber),
          IdentificationNumberForm(
            initialValue: _identificationNumber,
            onChanged: (value) => _onFormChanged('idNumber', value),
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
        case 'snn':
          _ssn = value!;
          break;
        case 'lastName':
          _idType = value!;
          break;
        case 'idNumber':
          _identificationNumber = value!;
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
      GoRouter.of(context).pushNamed(Routes.createProfile3.name);
    } else {
      // Form is invalid, show errors
      debugPrint('Form is invalid');
    }
  }
}
