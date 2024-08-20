import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/wallet_address_form.dart';

class CreateWalletForm extends StatefulWidget {
  const CreateWalletForm({super.key});

  @override
  State<CreateWalletForm> createState() => CreateWalletFormState();
}

class CreateWalletFormState extends State<CreateWalletForm> {
  final _formKey = GlobalKey<FormState>();
  String _address = '';
  bool _addressMinLength = false;

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
          WalletAddressForm(
            initialValue: _address,
            onChanged:
                _onFormChanged, // Call the corrected _onFormChanged method
          ),
          SizedBox(height: size * 0.35),
          CustomButton(
            border: Border.all(
                color: !_addressMinLength
                    ? AppColorSchema.of(context).secondaryButtonBorderColor
                    : Colors.transparent),
            color: !_addressMinLength
                ? Colors.transparent
                : AppColorSchema.of(context).buttonColor,
            text: l10n.verify,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            onPressed: _onButtonPressed,
          ),
          SizedBox(height: size * 0.025),
        ],
      ),
    );
  }

  // Method to handle form changes
  void _onFormChanged(String? value) {
    setState(() {
      _address = value!;
      _addressMinLength = value.length > 4;
    });
  }

  // Method to handle button actions
  void _onButtonPressed() {
    if (_formKey.currentState!.validate() && _addressMinLength) {
      _formKey.currentState!.reset();
      setState(() {
        _address = '';
        _addressMinLength = false;
      });
      _buildSuccessfulModal();
    }
  }

  // Method to build the successful modal
  Future<dynamic> _buildSuccessfulModal() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = AppLocalizations.of(context)!;
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          content: Center(
            child: Column(
              children: [
                TextBase(
                  text: l10n.walletSuccessMessage,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColorSchema.of(context).secondaryText,
                ),
                SizedBox(height: size * 0.005),
                TextBase(
                  text: l10n.continueCheckingProfile,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColorSchema.of(context).secondaryText,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
