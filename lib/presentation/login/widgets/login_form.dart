import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/email_form.dart';
import 'package:wallet_guru/presentation/core/widgets/password_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    return Form(
        key: _formKey, child: _buildEmailAndPasswordView(size, context, l10n));
  }

  Widget _buildEmailAndPasswordView(
      double size, BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            Assets.iconLogo,
          ),
          SizedBox(height: size * 0.05),
          const AuthLoginDivider(),
          TextBase(
            text: l10n.login,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size * 0.1),
          EmailForm(
            initialValue: _email,
            onChanged: (value) => _onFormChanged('email', value),
          ),
          SizedBox(height: size * 0.05),
          PasswordForm(
            initialValue: _password,
            onChanged: (value) => _onFormChanged('password', value),
          ),
          SizedBox(height: size * 0.025),
          TextBase(
              color: AppColorSchema.of(context).tertiaryText,
              text: l10n.sing_up_here,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          SizedBox(height: size * 0.025),
          TextBase(
              color: AppColorSchema.of(context).tertiaryText,
              text: l10n.forgot_password,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          SizedBox(height: size * 0.2),
          CustomButton(
            border:
                Border.all(color: AppColorSchema.of(context).buttonBorderColor),
            color: Colors.transparent,
            text: l10n.login,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            onPressed: () => _onButtonPressed('validateStepOne'),
          ),
        ],
      ),
    );
  }

  // Method to handle form changes
  void _onFormChanged(String formType, String? value) {
    setState(() {
      switch (formType) {
        case 'email':
          _email = value;
          break;
        case 'password':
          _password = value;
          break;
      }
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
