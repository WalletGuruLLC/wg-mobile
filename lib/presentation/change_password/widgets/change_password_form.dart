import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/core/form_managers/change_password_form_manager.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/change_password/widgets/change_password_button.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/current_password_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_form.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_confirm_form.dart';

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
  late ChangePasswordFormManager _formManager;

  @override
  void initState() {
    super.initState();
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    _formManager = ChangePasswordFormManager(userCubit);
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
          SizedBox(height: size * 0.025),
          Image.asset(Assets.iconLogo),
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
            initialValue: _formManager.currentPassword,
            onChanged: (value) => _formManager.updateCurrentPassword(value),
            hintText: l10n.enterCurrentPassword,
          ),
          SizedBox(height: size * 0.02),
          FormLabel(label: l10n.newPassword),
          PasswordForm(
            initialValue: _formManager.newPassword,
            hintText: l10n.enterNewPassword,
            onChanged: (value) => _formManager.updateNewPassword(value),
            underDecoration: true,
          ),
          SizedBox(height: size * 0.02),
          FormLabel(label: l10n.confirmPassword),
          PasswordConfirmForm(
            underDecoration: true,
            initialValue: _formManager.confirmNewPassword,
            passwordValue: _formManager.newPassword,
            hintText: l10n.enterConfirmPassword,
            onChanged: (value) => _formManager.updateConfirmNewPassword(value),
          ),
          SizedBox(height: size * 0.02),
          FormLabel(
            label: l10n.enterStrongPassword,
            color: AppColorSchema.of(context).tertiaryText,
          ),
          SizedBox(height: size * 0.1),
          const ChangePasswordButton(),
        ],
      ),
    );
  }
}
