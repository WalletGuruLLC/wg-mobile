import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guru/application/core/device/device.dart';
import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/domain/core/auth/biometric_auth_service.dart';
import 'package:wallet_guru/domain/core/enums/support_state_enum.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
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
  final BiometricAuthService _biometricAuthService = BiometricAuthService();
  final deviceType = getDeviceType();
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  late LoginCubit loginCubit;
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType> availableBiometrics = [];
  late bool isBiometricAvailable;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginCubit = BlocProvider.of<LoginCubit>(context);
      loginCubit.cleanFormStatusForgotPassword();
      _getInactiveSection();
      _initializeBiometricFeatures();
      _getIsBiometricAvailable();
    });
  }

  Future<void> _initializeBiometricFeatures() async {
    final isSupported = await _biometricAuthService.isDeviceSupported();
    final canCheckBiometric = await _biometricAuthService.canCheckBiometrics();
    final available = await _biometricAuthService.getAvailableBiometrics();

    if (!mounted) return;

    setState(() {
      supportState = isSupported
          ? SupportState.supported
          : (canCheckBiometric
              ? SupportState.notSupported
              : SupportState.unknown);
      availableBiometrics = available;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    double size = MediaQuery.of(context).size.height;
    return Form(
        key: _formKey,
        child: _buildEmailAndPasswordView(size, context, l10n, locale));
  }

  Widget _buildEmailAndPasswordView(
      double size, BuildContext context, AppLocalizations l10n, Locale locale) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          GestureDetector(
            onTap: () {
              loginCubit.cleanFormStatusLogin();
              GoRouter.of(context).pushNamed(Routes.forgotPassword.name);
            },
            child: TextBase(
                color: AppColorSchema.of(context).tertiaryText,
                text: l10n.forgot_password,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: size * 0.035),
          Visibility(
            visible: isBiometricAvailable,
            child: GestureDetector(
              onTap: () => _biometricAuthService.authenticateWithBiometric(),
              child: Center(
                child: SvgPicture.asset(
                  deviceType == DeviceType.android
                      ? Assets.walletAndroid
                      : Assets.walletIos,
                ),
              ),
            ),
          ),
          SizedBox(height: size * 0.1),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.formStatusLogin is SubmissionSuccess) {
                loginCubit.cleanFormStatusLogin();
                GoRouter.of(context).pushNamed(Routes.doubleFactorAuth.name,
                    extra: state.email);
              } else if (state.formStatusLogin is SubmissionFailed) {
                _buildErrorModal(
                  state.customMessage,
                  state.customMessageEs,
                  state.customCode,
                  locale,
                );
              }
            },
            builder: (context, state) {
              if (state.formStatusLogin is FormSubmitting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CustomButton(
                  border: Border.all(
                      color: AppColorSchema.of(context).buttonBorderColor),
                  color: Colors.transparent,
                  text: l10n.login,
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
          onPressed: () {
            loginCubit.cleanFormStatus();
            loginCubit.cleanFormStatusLogin();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> _getInactiveSection() async {
    final storage = await SharedPreferences.getInstance();
    bool? inactiveSection = storage.getBool('inactiveSection');
    if (inactiveSection != null && inactiveSection) {
      _setInactiveSessionAndShowModal();
    }
  }

  Future<void> _getIsBiometricAvailable() async {
    final storage = await SharedPreferences.getInstance();
    bool? isBiometricAvailable = storage.getBool('isBiometricAvailable');
    setState(() {
      this.isBiometricAvailable = isBiometricAvailable ?? false;
    });
  }

  Future<void> _setInactiveSessionAndShowModal() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final l10n = AppLocalizations.of(context)!;
        return BaseModal(
          buttonText: "OK",
          buttonWidth: MediaQuery.of(context).size.width * 0.4,
          content: Column(
            children: [
              const SizedBox(height: 10),
              TextBase(
                text: l10n.loggedOutTitle,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.loggedOutText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            final storage = await SharedPreferences.getInstance();
            storage.setBool('inactiveSection', false);
            // Close the modal
          },
        );
      },
    );
  }
}
