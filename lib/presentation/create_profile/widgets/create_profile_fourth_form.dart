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
import 'package:wallet_guru/presentation/core/widgets/forms/avatar_form.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/date_picker_field.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';

class CreateProfileFourthForm extends StatefulWidget {
  const CreateProfileFourthForm({super.key});

  @override
  State<CreateProfileFourthForm> createState() =>
      CreateProfileFourthFormState();
}

class CreateProfileFourthFormState extends State<CreateProfileFourthForm> {
  final _formKey = GlobalKey<FormState>();
  late CreateProfileCubit createProfileCubit;

  @override
  void initState() {
    super.initState();
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    double size = MediaQuery.of(context).size.height;
    return Form(
        key: _formKey,
        child: _buildProfileOtherInfoView(size, context, l10n, locale));
  }

  Widget _buildProfileOtherInfoView(
      double size, BuildContext context, AppLocalizations l10n, Locale locale) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const UserProfileDescription(),
          const ProgressBar(
            currentStep: 4,
          ),
          SizedBox(height: size * 0.040),
          FormLabel(label: l10n.dateOfBirth),
          DatePickerForm(onDateChanged: (DateTime? value) {}),
          SizedBox(height: size * 0.040),
          FormLabel(label: l10n.avatar),
          const SizedBox(height: 10),
          const AvatarForm(),
          SizedBox(height: size * 0.12),
          BlocConsumer<CreateProfileCubit, CreateProfileState>(
              listener: (context, state) {
            if (state.formStatus is SubmissionSuccess) {
              GoRouter.of(context).pushReplacementNamed(
                Routes.createWallet.name,
              );
            } else if (state.formStatus is SubmissionFailed) {
              buildErrorModal(
                state.customMessage,
                state.customMessageEs,
                state.customCode,
                locale,
              );
            }
          }, builder: (context, state) {
            if (state.formStatus is FormSubmitting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return CreateProfileButtons(
                onPressed1: _onBackButtonPressed,
                onPressed2: _onNextButtonPressed,
              );
            }
          }),
        ],
      ),
    );
  }

  void _onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  // Method to handle button actions
  void _onNextButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      debugPrint('Form is valid');
      createProfileCubit.emitCreateProfile();
    }
  }

  // Method to build the successful modal
  Future<dynamic> buildErrorModal(
    String descriptionEn,
    String descriptionEs,
    String codeError,
    Locale locale,
  ) {
    String description =
        locale.languageCode == 'en' ? descriptionEn : descriptionEs;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
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
            createProfileCubit.cleanFormStatus();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
