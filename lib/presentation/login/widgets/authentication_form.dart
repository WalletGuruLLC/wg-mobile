import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';

import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/otp_form.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({super.key, required this.email});
  final String email;

  @override
  State<AuthenticationForm> createState() => AuthenticationFormState();
}

class AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _otp;
  late LoginCubit loginCubit;
  late Timer _timer;
  int _remainingSeconds = 300;

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
    return Form(
      key: _formKey,
      child: _buildValidateOtpView(size, context, l10n, locale),
    );
  }

  Widget _buildValidateOtpView(
      double size, BuildContext context, AppLocalizations l10n, Locale locale) {
    final int minutes = _remainingSeconds ~/ 60;
    final int seconds = _remainingSeconds % 60;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            text:
                '${l10n.valid_code_time} ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} s',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size * 0.35),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.formStatusOtp is SubmissionSuccess) {
                if (state.firstName.isEmpty && state.lastName.isEmpty) {
                  BlocProvider.of<CreateProfileCubit>(context)
                      .generateSumSubAccessToken(state.userId);

                  GoRouter.of(context).pushNamed(
                    Routes.createProfile1.name,
                    extra: {
                      "id": state.userId,
                      "email": state.email,
                    },
                  );
                } else if (state.country.isEmpty) {
                  GoRouter.of(context).pushNamed(
                    Routes.createProfile2.name,
                    extra: {
                      "id": state.userId,
                      "email": state.email,
                    },
                  );
                } else if (state.phone.isEmpty) {
                  GoRouter.of(context).pushNamed(
                    Routes.createProfile3.name,
                    extra: {
                      "id": state.userId,
                      "email": state.email,
                    },
                  );
                } else if (state.picture.isEmpty) {
                  GoRouter.of(context).pushNamed(
                    Routes.createProfile4.name,
                    extra: {
                      "id": state.userId,
                      "email": state.email,
                    },
                  );
                } else if (!state.isFirstTime) {
                  GoRouter.of(context).pushReplacementNamed(Routes.home.name);
                } else {
                  GoRouter.of(context).pushNamed(Routes.createWallet.name);
                }
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
          SizedBox(
            child: GestureDetector(
              onTap: () {
                loginCubit.emitResendOtp(widget.email);
                _remainingSeconds = 300;
              },
              child: TextBase(
                color: AppColorSchema.of(context).tertiaryText,
                text: l10n.resend_code,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to handle form changes
  void _onFormChanged(String? value) {
    setState(() {
      _otp = value;
      loginCubit.setOtp(_otp);
    });
  }

  // Method to handle button actions
  void _onButtonPressed(String action) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loginCubit.emitVerifyEmailOtp(widget.email);
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
