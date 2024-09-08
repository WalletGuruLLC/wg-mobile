import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/current_password_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_form.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_confirm_form.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => ChangePasswordFormState();
}

class ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _currentPassword;
  String? _newPassword;
  String? _confirmNewPassword;
  late UserCubit userCubit;

  @override
  void initState() {
    userCubit = BlocProvider.of<UserCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    double size = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: size * 0.025),
          Image.asset(
            Assets.iconLogo,
          ),
          SizedBox(height: size * 0.05),
          const AuthLoginDivider(),
          TextBase(
            text: l10n.changePassword,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size * 0.1),
          FormLabel(label: l10n.currentPassword),
          CurrentPasswordForm(
            initialValue: _currentPassword,
            onChanged: (value) =>
                _onPasswordFieldChanged(value, PasswordFieldType.current),
            hintText: l10n.enterCurrentPassword,
          ),
          SizedBox(height: size * 0.02),
          FormLabel(label: l10n.newPassword),
          PasswordForm(
              initialValue: _newPassword,
              hintText: l10n.enterNewPassword,
              onChanged: (value) =>
                  _onPasswordFieldChanged(value, PasswordFieldType.newPassword),
              underDecoration: true),
          SizedBox(height: size * 0.02),
          FormLabel(label: l10n.confirmPassword),
          PasswordConfirmForm(
            underDecoration: true,
            initialValue: _confirmNewPassword,
            passwordValue: _newPassword,
            hintText: l10n.enterConfirmPassword,
            onChanged: (value) => _onPasswordFieldChanged(
                value, PasswordFieldType.confirmNewPassword),
          ),
          SizedBox(height: size * 0.025),
          SizedBox(height: size * 0.2),
          BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.formStatus is FormSubmitting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CustomButton(
                  border: Border.all(
                      color: AppColorSchema.of(context).buttonBorderColor),
                  color: Colors.transparent,
                  text: l10n.title_register,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  onPressed: () => _onButtonPressed('validateStepOne'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _onPasswordFieldChanged(String? value, PasswordFieldType fieldType) {
    setState(() {
      switch (fieldType) {
        case PasswordFieldType.current:
          _currentPassword = value;
          userCubit.setCurrentPassword(value);
          break;
        case PasswordFieldType.newPassword:
          _newPassword = value;
          userCubit.setNewPassword(value);
          break;
        case PasswordFieldType.confirmNewPassword:
          _confirmNewPassword = value;
          break;
      }
    });
  }

  void _onButtonPressed(String action) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // userCubit.emitUserCreate();
      });
    }
  }

  // Method to build the successful modal
  Future<dynamic> _buildErrorModal(
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
            userCubit.resetFormStatus();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

enum PasswordFieldType {
  current,
  newPassword,
  confirmNewPassword,
}
