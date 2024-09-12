import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/application/settings/settings_state.dart';
import 'package:wallet_guru/application/settings/settings_cubit.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/email_form.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_form.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_confirm_form.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _passwordConfirm;
  late RegisterCubit registerCubit;
  bool acceptTerms = false;
  bool acceptPrivacy = false;

  String termsUrl = '';
  String privacyUrl = '';

  @override
  void initState() {
    registerCubit = BlocProvider.of<RegisterCubit>(context);
    BlocProvider.of<SettingsCubit>(context).loadSettings();
    super.initState();
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    double size = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const AuthLoginDivider(),
          TextBase(
            text: l10n.title_register,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          TextBase(
            text: l10n.description_register,
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
          PasswordConfirmForm(
            initialValue: _passwordConfirm,
            passwordValue: _password,
            hintText: l10n.confirm_password,
            onChanged: _onPasswordConfirmChanged,
          ),
          SizedBox(height: size * 0.025),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                final termsSetting = state.settings
                    .firstWhere((s) => s.key == 'terms-condition');
                final privacySetting =
                    state.settings.firstWhere((s) => s.key == 'privacy-police');
                termsUrl = termsSetting.value;
                privacyUrl = privacySetting.value;
              }
              return Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: acceptTerms,
                        activeColor: AppColorSchema.of(context).tertiaryText,
                        onChanged: (bool? value) {
                          setState(() {
                            acceptTerms = value!;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(termsUrl),
                        child: TextBase(
                          text: l10n.accept_terms_and_conditions,
                          color: AppColorSchema.of(context).tertiaryText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: acceptPrivacy,
                        activeColor: AppColorSchema.of(context).tertiaryText,
                        onChanged: (bool? value) {
                          setState(() {
                            acceptPrivacy = value!;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(privacyUrl),
                        child: TextBase(
                          text: l10n.accept_privacy_policy,
                          color: AppColorSchema.of(context).tertiaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          SizedBox(height: size * 0.1),
          BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state.formStatus is SubmissionSuccess) {
                GoRouter.of(context).pushNamed(Routes.doubleFactorAuth.name,
                    extra: state.email);
              } else if (state.formStatus is SubmissionFailed) {
                _buildErrorModal(
                  state.customMessage,
                  state.customMessageEs,
                  state.customCode,
                  locale,
                );
              }
            },
            builder: (context, state) {
              if (state.formStatus is FormSubmitting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CustomButton(
                  border: Border.all(
                      color: AppColorSchema.of(context).buttonBorderColor),
                  color: Colors.transparent,
                  text: l10n.title_register,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  onPressed: () => _onButtonPressed('validateStepOne'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _onEmailChanged(String? value) {
    setState(() {
      _email = value;
      registerCubit.setSignUpEmail(value);
    });
  }

  void _onPasswordChanged(String? value) {
    setState(() {
      _password = value;
      registerCubit.setUserPassword(value);
    });
  }

  void _onPasswordConfirmChanged(String? value) {
    setState(() {
      _passwordConfirm = value;
    });
  }

  void _onButtonPressed(String action) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        registerCubit.emitUserCreate();
      });
    }
  }

  // Method to build the successful modal
  Future<dynamic> _buildErrorModal(
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
            registerCubit.cleanFormStatus();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
