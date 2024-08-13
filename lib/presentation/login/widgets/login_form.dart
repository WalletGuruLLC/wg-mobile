import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/email_form.dart';
import 'package:wallet_guru/presentation/core/widgets/password_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

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
    double size = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            Assets.iconLogo,
          ),
          SizedBox(height: size * 0.05),
          SizedBox(
            width: 67,
            child: Divider(
              color: AppColorSchema.of(context).lineColor,
              thickness: 4,
            ),
          ),
          const TextBase(
            text: 'Login',
            fontSize: 20,
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
          SizedBox(height: size * 0.025),
          TextBase(
              color: AppColorSchema.of(context).terciaryText,
              text: 'Don\'t have an account? Sign up here',
              fontSize: 16,
              fontWeight: FontWeight.w400),
          SizedBox(height: size * 0.025),
          TextBase(
              color: AppColorSchema.of(context).terciaryText,
              text: 'Forgot password?',
              fontSize: 16,
              fontWeight: FontWeight.w400),
          SizedBox(height: size * 0.2),
          CustomButton(
            border:
                Border.all(color: AppColorSchema.of(context).buttonBorderColor),
            color: Colors.transparent,
            text: 'Login',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
          ),
        ],
      ),
    );
  }

  void _onEmailChanged(String? value, bool isValid) {
    setState(() {
      _email = value;
    });
  }

  void _onPasswordChanged(String? value, bool isValid) {
    setState(() {
      _password = value;
    });
  }
}
