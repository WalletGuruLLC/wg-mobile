import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/otp_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({super.key});

  @override
  State<AuthenticationForm> createState() => AuthenticationFormState();
}

class AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _otp;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    return Form(
        key: _formKey, child: _buildValidateOtpView(size, context, l10n));
  }

  Widget _buildValidateOtpView(
      double size, BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
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
          SizedBox(height: size * 0.05),
          OtpForm(
            initialValue: _otp,
            onChanged: (value) => _onFormChanged('otp', value),
          ),
          SizedBox(height: size * 0.025),
          TextBase(
              color: AppColorSchema.of(context).tertiaryText,
              text: l10n.valid_code_time,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          SizedBox(height: size * 0.35),
          CustomButton(
            border: Border.all(
                color: AppColorSchema.of(context).secondaryButtonBorderColor),
            color: Colors.transparent,
            text: l10n.verify,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            onPressed: () => _onButtonPressed('validateOtp'),
          ),
          SizedBox(height: size * 0.025),
          TextBase(
              color: AppColorSchema.of(context).tertiaryText,
              text: l10n.resend_code,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ],
      ),
    );
  }

  // Method to handle form changes
  void _onFormChanged(String formType, String? value) {
    setState(() {
      switch (formType) {
        case 'otp':
          _otp = value;
          break;
      }
    });
  }

  // Method to handle button actions
  void _onButtonPressed(String action) {
    if (_formKey.currentState!.validate()) {
      setState(() {});
    }
  }
}
