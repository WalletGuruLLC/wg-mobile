import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_form.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/current_password_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_confirm_form.dart';
import 'package:wallet_guru/presentation/change_password/widgets/change_password_button.dart';

enum PasswordFieldType {
  current,
  newPassword,
  confirmNewPassword,
}

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => ChangePasswordFormState();
}

class ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late UserCubit userCubit;
  String? _currentPassword;
  String? _newPassword;
  String? _confirmNewPassword;

  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                Assets.iconLogo,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const AuthLoginDivider(),
          TextBase(
            text: l10n.changePassword,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size * 0.08),
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
          SizedBox(height: size * 0.02),
          FormLabel(
            label: l10n.enterStrongPassword,
            color: AppColorSchema.of(context).tertiaryText,
          ),
          SizedBox(height: size * 0.1),
          ChangePasswordButton(formKey: _formKey),
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
          userCubit.setConfirmNewPassword(value);
          break;
      }
      // validate passwords
      userCubit.validatePasswords();
    });
  }
}
