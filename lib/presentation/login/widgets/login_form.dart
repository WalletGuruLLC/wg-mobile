import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/email_form.dart';
import 'package:wallet_guru/presentation/core/widgets/otp_form.dart';
import 'package:wallet_guru/presentation/core/widgets/password_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FormStep {
  validateEmailAndPassword,
  validateOtp,
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _otp;
  FormStep _currentStep = FormStep.validateEmailAndPassword;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: _currentStep == FormStep.validateEmailAndPassword
          ? _buildEmailAndPasswordView(size, context, l10n)
          : _buildValidateOtpView(size, context, l10n),
    );
  }

  Widget _buildEmailAndPasswordView(
      double size, BuildContext context, AppLocalizations l10n) {
    return Column(
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
        TextBase(
          text: l10n.login,
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
          onPressed: _validateStepOne,
        ),
      ],
    );
  }

  Widget _buildValidateOtpView(
      double size, BuildContext context, AppLocalizations l10n) {
    return Column(
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
        TextBase(
          text: l10n.otp_authentication,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: size * 0.005),
        TextBase(
          text: l10n.otp_authentication_description,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: size * 0.1),
        OtpForm(
          initialValue: _otp,
          onChanged: _onOtpChanged,
        ),
        SizedBox(height: size * 0.025),
        TextBase(
            color: AppColorSchema.of(context).tertiaryText,
            text: l10n.valid_code_time,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        SizedBox(height: size * 0.4),
        CustomButton(
          border:
              Border.all(color: AppColorSchema.of(context).buttonBorderColor),
          color: Colors.transparent,
          text: l10n.verify,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          onPressed: _validateOtp,
        ),
        SizedBox(height: size * 0.025),
        TextBase(
            color: AppColorSchema.of(context).tertiaryText,
            text: l10n.resend_code,
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ],
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

  void _onOtpChanged(String? value, bool isValid) {
    setState(() {
      _otp = value;
    });
  }

  void _validateStepOne() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _currentStep = FormStep.validateOtp; // Cambiar al segundo paso
      });
    }
  }

  void _validateOtp() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Validate OTP');
    }
  }
}
