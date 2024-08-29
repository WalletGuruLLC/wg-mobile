import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';

import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/last_name_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/first_name_form.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/phone_number_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
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
  late CreateProfileCubit createProfileCubit;

  @override
  void initState() {
    BlocProvider.of<LoginCubit>(context).initialStatus();
    BlocProvider.of<RegisterCubit>(context).initialStatus();

    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
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
          PhoneNumberForm(
            initialValue: _phoneNumber,
            onChanged: (value) => _onFormChanged('phoneNumber', value),
          ),
          SizedBox(height: size * 0.12),
          BlocConsumer<CreateProfileCubit, CreateProfileState>(
            listener: (context, state) {
              if (state.formStatusOne is SubmissionSuccess) {
                GoRouter.of(context).pushNamed(Routes.createProfile2.name);
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
