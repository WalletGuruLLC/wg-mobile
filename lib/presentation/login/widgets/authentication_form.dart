import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/otp_form.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({super.key});

  @override
  State<AuthenticationForm> createState() => AuthenticationFormState();
}

class AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _otp;
  late LoginCubit loginCubit;

  @override
  void initState() {
    loginCubit = BlocProvider.of<LoginCubit>(context);
    super.initState();
  }

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
          const AuthLoginDivider(),
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
            onChanged: _onFormChanged,
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
  void _onFormChanged(String? value) {
    setState(() {
      _otp = value;
      loginCubit.setOtp(value);
    });
  }

  // Method to handle button actions
  void _onButtonPressed(String action) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loginCubit.emitVerifyEmailOtp();
      });
    }
  }
}
