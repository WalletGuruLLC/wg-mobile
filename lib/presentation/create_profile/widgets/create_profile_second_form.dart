import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/social_security_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/identification_number_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/identification_type_drop_form.dart';

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
  late CreateProfileCubit createProfileCubit;

  @override
  void initState() {
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
    //createProfileCubit.cleanFormStatusOne();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    _idType = createProfileCubit.state.identificationType.isNotEmpty
        ? createProfileCubit.state.identificationType
        : _idType;
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
            initialValue:
                createProfileCubit.state.socialSecurityNumber.isNotEmpty
                    ? createProfileCubit.state.socialSecurityNumber
                    : _ssn,
            onChanged: (value) => _onFormChanged('snn', value),
          ),
          const SizedBox(height: 30),
          FormLabel(label: l10n.idType),
          IdentificationTypeDropForm(
            initialValue: _idType.isNotEmpty && _idType.contains(_idType)
                ? _idType
                : null,
            hintText: l10n.selectIdType,
            items: [l10n.nationalId, l10n.passport, l10n.driversLicense],
            onChanged: (value) => _onFormChanged('idType', value),
          ),
          const SizedBox(height: 30),
          FormLabel(label: l10n.identificationNumber),
          IdentificationNumberForm(
            initialValue:
                createProfileCubit.state.identificationNumber.isNotEmpty
                    ? createProfileCubit.state.identificationNumber
                    : _identificationNumber,
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
          createProfileCubit.setSocialSecurityNumber(_ssn);
          break;
        case 'idType':
          _idType = value!;
          createProfileCubit.setIdentificationType(_idType);
          break;
        case 'idNumber':
          _identificationNumber = value!;
          createProfileCubit.setIdentificationNumber(_identificationNumber);
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
      debugPrint('Form is valid');
      //createProfileCubit.emitCreateProfileTwo();
      GoRouter.of(context).pushNamed(Routes.createProfile3.name);
    }
  }
}
