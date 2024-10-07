import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/email_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_form.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/otp_form.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

enum FormStep { validateEmail, changePassword }

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    super.key,
  });

  @override
  State<ForgotPasswordForm> createState() => ForgotPasswordFormState();
}

class ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _otp;
  String? _email;
  late LoginCubit loginCubit;
  late Timer _timer;
  int _remainingSeconds = 300;
  FormStep _formStep = FormStep.validateEmail;
  String? _password;

  @override
  void initState() {
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
    loginCubit.cleanFormStatus();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    double size = MediaQuery.of(context).size.height;
    return _formStep == FormStep.validateEmail
        ? _buildValidateEmailView(size, context, l10n, locale)
        : _buildValidateOtpView(size, context, l10n, locale);
  }

  Widget _buildValidateEmailView(
      double size, BuildContext context, AppLocalizations l10n, Locale locale) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const AuthLoginDivider(),
            const TextBase(
              text: 'Forgot Password',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: size * 0.005),
            const TextBase(
              text:
                  'Please provide the email address associated with your account',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: size * 0.05),
            EmailForm(
              initialValue: _email,
              onChanged: (value) => _onFormChanged('email', value),
            ),
            SizedBox(height: size * 0.025),
            SizedBox(height: size * 0.35),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.formStatusOtp is FormSubmitting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return CustomButton(
                      border: Border.all(
                          color: AppColorSchema.of(context)
                              .secondaryButtonBorderColor),
                      color: Colors.transparent,
                      text: l10n.verify,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        _onButtonPressed('validateEmail');
                      });
                }
              },
            ),
            SizedBox(height: size * 0.025),
          ],
        ),
      ),
    );
  }

  Widget _buildValidateOtpView(
      double size, BuildContext context, AppLocalizations l10n, Locale locale) {
    final int minutes = _remainingSeconds ~/ 60;
    final int seconds = _remainingSeconds % 60;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const AuthLoginDivider(),
            const TextBase(
              text: 'Forgot Password',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: size * 0.005),
            const TextBase(
              text:
                  'Please provide the OTP sent to your email and a new password',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: size * 0.05),
            OtpForm(
              initialValue: _otp,
              onChanged: (value) => _onFormChanged('otp', value),
            ),
            SizedBox(height: size * 0.025),
            PasswordForm(
              initialValue: _password,
              onChanged: (value) => _onFormChanged('password', value),
            ),
            SizedBox(height: size * 0.025),
            TextBase(
              color: AppColorSchema.of(context).tertiaryText,
              text:
                  '${l10n.valid_code_time} ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} s',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: size * 0.35),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.formStatusForgotPassword is SubmissionSuccess) {
                  GoRouter.of(context).goNamed(Routes.logIn.name);
                } else if (state.formStatusOtp is SubmissionFailed) {
                  buildErrorModal(
                    state.customMessage,
                    state.customMessageEs,
                    state.customCode,
                    locale,
                  );
                }
              },
              builder: (context, state) {
                if (state.formStatusOtp is FormSubmitting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return CustomButton(
                    border: Border.all(
                        color: AppColorSchema.of(context)
                            .secondaryButtonBorderColor),
                    color: Colors.transparent,
                    text: l10n.verify,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    onPressed: () => _onButtonPressed('validateOtp'),
                  );
                }
              },
            ),
            SizedBox(height: size * 0.025),
          ],
        ),
      ),
    );
  }

  // Method to handle form changes
  void _onFormChanged(String formType, String? value) {
    setState(() {
      switch (formType) {
        case 'email':
          _email = value;
          loginCubit.setUserForgotPasswordEmail(value);
          break;
        case 'otp':
          _otp = value;
          loginCubit.setForgotPasswordOtp(value);
          break;
        case 'password':
          _password = value;
          loginCubit.setUserForgotPasswordNewPassword(value);
          break;
      }
    });
  }

  // Method to handle button actions
  void _onButtonPressed(String action) {
    if (_formKey.currentState!.validate() && action == 'validateEmail') {
      setState(() {
        loginCubit.emitForgotPassword();
        _formStep = FormStep.changePassword;
      });
    }
    if (_formKey.currentState!.validate() && action == 'validateOtp') {
      setState(() {
        loginCubit.emitChangePassword();
        loginCubit.cleanFormStatusForgotPassword();
        // loginCubit.changePassword();
      });
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
            loginCubit.cleanFormStatusOtp();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
