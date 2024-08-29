import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
//import 'package:wallet_guru/presentation/core/widgets/forms/dropdown_base.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
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
    createProfileCubit.cleanFormStatusOne();
    super.initState();
  }

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
            initialValue: _idType.isNotEmpty && _idType.contains(_idType)
                ? _idType
                : null,
            hintText: 'Select you ID type',
            items: const ['National ID', 'Passport', 'Driver´s lisence'],
            onChanged: (value) => _onFormChanged('idType', value),
          ),
          const SizedBox(height: 30),
          FormLabel(label: l10n.identificationNumber),
          IdentificationNumberForm(
            initialValue: _identificationNumber,
            onChanged: (value) => _onFormChanged('idNumber', value),
          ),
          SizedBox(height: size * 0.12),
          BlocConsumer<CreateProfileCubit, CreateProfileState>(
            listener: (context, state) {
              if (state.formStatusOne is SubmissionSuccess) {
                GoRouter.of(context).pushNamed(Routes.createProfile3.name);
              } else if (state.formStatusOne is SubmissionFailed) {
                _buildlModal(state.customMessage, state.customCode);
              }
            },
            builder: (context, state) {
              if (state.formStatusOne is FormSubmitting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CreateProfileButtons(
                  onPressed1: _onBackButtonPressed,
                  onPressed2: _onNextButtonPressed,
                );
              }
            },
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
        case 'idType':
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
      //createProfileCubit.cleanFormStatusTwo();
      GoRouter.of(context).pushNamed(Routes.createProfile3.name);
    } else {
      // Form is invalid, show errors
      debugPrint('Form is invalid');
    }
  }

  // Method to build the successful modal
  Future<dynamic> _buildlModal(String description, String codeError) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          isFail: true,
          content: Column(
            children: [
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: description,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: codeError,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            createProfileCubit.cleanFormStatusOne();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
