import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/application/settings/settings_cubit.dart';
import 'package:wallet_guru/application/settings/settings_state.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/application/create_wallet/create_wallet_cubit.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/wallet_address_form.dart';

class CreateWalletForm extends StatefulWidget {
  const CreateWalletForm({super.key});

  @override
  State<CreateWalletForm> createState() => CreateWalletFormState();
}

class CreateWalletFormState extends State<CreateWalletForm> {
  final _formKey = GlobalKey<FormState>();
  String _address = '';
  bool _addressMinLength = false;
  bool _isVisible = true;
  late CreateWalletCubit createWalletCubit;
  late TextEditingController _addressController; // Nuevo controlador
  String walletUrl = '';

  @override
  void initState() {
    super.initState();
    createWalletCubit = BlocProvider.of<CreateWalletCubit>(context);
    final loginCubit = BlocProvider.of<LoginCubit>(context);

    loginCubit.cleanFormStatus();
    loginCubit.cleanFormStatusOtp();
    _addressController =
        TextEditingController(text: _address); // Inicializar controlador
  }

  @override
  void dispose() {
    _addressController.dispose(); // Liberar el controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    double size = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: _buildEmailAndPasswordView(size, context, l10n, locale),
    );
  }

  Widget _buildEmailAndPasswordView(
    double size,
    BuildContext context,
    AppLocalizations l10n,
    Locale locale,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const AuthLoginDivider(),
          TextBase(
            text: l10n.createWalletAddress,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size * 0.005),
          TextBase(
            text: l10n.generateUniqueWallet,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size * 0.030),
          TextBase(
            text: l10n.enterDesiredName,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size * 0.030),
          TextBase(
            text: l10n.addressName,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: size * 0.015),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                final walletUrlSetting =
                    state.settings.firstWhere((s) => s.key == 'url-wallet');
                walletUrl = walletUrlSetting.value;
              }
              return Visibility(
                visible: _isVisible,
                child: TextBase(
                  text: walletUrl,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              );
            },
          ),
          SizedBox(height: size * 0.015),
          WalletAddressForm(
            controller:
                _addressController, // Asignar el controlador al formulario
            onChanged: _onFormChanged,
          ),
          SizedBox(height: size * 0.015),
          Visibility(
            visible: !_isVisible,
            child: TextBase(
              text: '$walletUrl/$_address',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          !_isVisible ? SizedBox(height: size * 0.015) : const SizedBox(),
          GestureDetector(
            onTap: () {
              String randomAddress = _generateRandomAddress();
              _onFormChanged(randomAddress);
            },
            child: TextBase(
              color: AppColorSchema.of(context).tertiaryText,
              text: 'Random',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: size * 0.20),
          BlocConsumer<CreateWalletCubit, CreateWalletState>(
            listener: (context, state) {
              if (state.formStatus is SubmissionSuccess) {
                _buildSuccessfulModal(
                    state.customMessage, state.customMessageEs, locale);
              } else if (state.formStatus is SubmissionFailed) {
                _buildErrorModal(state.customMessage, state.customMessageEs,
                    state.customCode, locale, l10n);
              }
            },
            builder: (context, state) {
              if (state.formStatus is FormSubmitting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CustomButton(
                  border: Border.all(
                    color: !_addressMinLength
                        ? AppColorSchema.of(context).secondaryButtonBorderColor
                        : Colors.transparent,
                  ),
                  color: !_addressMinLength
                      ? Colors.transparent
                      : AppColorSchema.of(context).buttonColor,
                  text: l10n.create,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  onPressed: _onButtonPressed,
                );
              }
            },
          ),
          SizedBox(height: size * 0.025),
        ],
      ),
    );
  }

  // Método para manejar los cambios en el formulario
  void _onFormChanged(String? value) {
    setState(() {
      _address = value!;
      _addressMinLength = value.length > 3;
      createWalletCubit.setUserWalletName(_address);
      _isVisible = _address.isNotEmpty ? false : true;
      _addressController.text = _address; // Actualizar el controlador
    });
  }

  // Método para manejar el botón
  void _onButtonPressed() {
    if (_formKey.currentState!.validate() && _addressMinLength) {
      _formKey.currentState!.reset();
      setState(() {
        _addressMinLength = false;
        createWalletCubit.emitFetchWalletAssetId();
      });
    }
  }

  // Método para construir el modal exitoso
  Future<dynamic> _buildSuccessfulModal(
    String descriptionEn,
    String descriptionEs,
    Locale locale,
  ) {
    String description =
        locale.languageCode == 'en' ? descriptionEn : descriptionEs;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = AppLocalizations.of(context)!;
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          isSucefull: true,
          buttonWidth: locale.languageCode == 'en'
              ? MediaQuery.of(context).size.width * 0.40
              : MediaQuery.of(context).size.width * 0.42,
          content: Column(
            children: [
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.walletSuccessMessage,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: description,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            createWalletCubit.emitInitialStatus();
            Navigator.of(context).pop();
            GoRouter.of(context).pushReplacementNamed(
              Routes.home.name,
            );
          },
        );
      },
    );
  }

  // Placeholder para el método del modal de error
  void _buildErrorModal(
    String descriptionEn,
    String descriptionEs,
    String codeError,
    Locale locale,
    AppLocalizations l10n,
  ) {
    String description =
        locale.languageCode == 'en' ? descriptionEn : descriptionEs;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          buttonWidth: locale.languageCode == 'en'
              ? MediaQuery.of(context).size.width * 0.40
              : MediaQuery.of(context).size.width * 0.42,
          isSucefull: false,
          content: Column(
            children: [
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.walletNameTaken,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: description,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            createWalletCubit.emitInitialStatus();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  String _generateRandomAddress() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    Random rnd = Random();

    String randomChars = String.fromCharCodes(
      Iterable.generate(3, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
    String randomNumbers = (rnd.nextInt(90) + 10).toString();

    return randomChars + randomNumbers;
  }
}
