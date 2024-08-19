import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/email_form.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/password_form.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: size * 0.05),
          const AuthLoginDivider(),
          const TextBase(
            text: 'Sign Up',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          const TextBase(
            text:
                'To create an account, please complete the following information',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size * 0.1),
          EmailForm(
            initialValue: _email,
            onChanged: _onEmailChanged,
          ),
          SizedBox(height: size * 0.05),
          PasswordForm(
            initialValue: _password,
            onChanged: _onPasswordChanged,
          ),
          SizedBox(height: size * 0.05),
          PasswordForm(
            initialValue: _password,
            hintText: l10n.confirm_password,
            onChanged: _onPasswordChanged,
          ),
          SizedBox(height: size * 0.025),
          SizedBox(height: size * 0.2),
          CustomButton(
            border:
                Border.all(color: AppColorSchema.of(context).buttonBorderColor),
            color: Colors.transparent,
            text: 'Sing Up',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            onPressed: () => _onButtonPressed('validateStepOne'),
          ),
        ],
      ),
    );
  }

  void _onEmailChanged(String? value) {
    setState(() {
      _email = value;
    });
  }

  void _onPasswordChanged(String? value) {
    setState(() {
      _password = value;
    });
  }

  // Method to handle button actions
  void _onButtonPressed(String action) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        GoRouter.of(context).pushNamed(Routes.doubleFactorAuth.name);
      });
    }
  }
}
