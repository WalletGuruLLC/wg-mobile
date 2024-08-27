import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/email_form.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/password_form.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
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
          GestureDetector(
            onTap: () => GoRouter.of(context).pushNamed(Routes.signUp.name),
            child: TextBase(
                color: AppColorSchema.of(context).tertiaryText,
                text: l10n.sing_up_here,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: size * 0.025),
          TextBase(
              color: AppColorSchema.of(context).tertiaryText,
              text: l10n.forgot_password,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          SizedBox(height: size * 0.2),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.formStatus is SubmissionSuccess) {
                GoRouter.of(context).pushNamed(Routes.doubleFactorAuth.name,
                    extra: state.email);
              } else if (state.formStatus is SubmissionFailed) {
                _buildlModal(state.customMessage, state.customCode);
              }
            },
            builder: (context, state) {
              return CustomButton(
                border: Border.all(
                    color: AppColorSchema.of(context).buttonBorderColor),
                color: Colors.transparent,
                text: l10n.login,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                onPressed: () => _onButtonPressed('validateStepOne'),
              );
            },
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
          loginCubit.setUserEmail(value);
          break;
        case 'password':
          _password = value;
          loginCubit.setUserPassword(value);
          break;
      }
    });
  }

  // Method to handle button actions
  void _onButtonPressed(String action) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loginCubit.emitSignInUser();
      });
    }
  }

  // Method to build the successful modal
  Future<dynamic> _buildlModal(String description, String codeError) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        //final l10n = AppLocalizations.of(context)!;
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
        );
      },
    );
  }
}
