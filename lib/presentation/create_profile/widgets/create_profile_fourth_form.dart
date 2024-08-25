import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/wallet_address_form.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';

class CreateProfileFourthForm extends StatefulWidget {
  const CreateProfileFourthForm({super.key});

  @override
  State<CreateProfileFourthForm> createState() =>
      CreateProfileFourthFormState();
}

class CreateProfileFourthFormState extends State<CreateProfileFourthForm> {
  final _formKey = GlobalKey<FormState>();
  String _address = '';
  bool _addressMinLength = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    return Form(
        key: _formKey, child: _buildProfileOtherInfoView(size, context, l10n));
  }

  Widget _buildProfileOtherInfoView(
      double size, BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const UserProfileDescription(),
          const ProgressBar(
            currentStep: 4,
          ),
          SizedBox(height: size * 0.040),
          FormLabel(label: l10n.dateOfBirth),
          WalletAddressForm(
            initialValue: _address,
            onChanged:
                _onFormChanged, // Call the corrected _onFormChanged method
          ),
          SizedBox(height: size * 0.040),
          FormLabel(label: l10n.avatar),
          WalletAddressForm(
            initialValue: _address,
            onChanged:
                _onFormChanged, // Call the corrected _onFormChanged method
          ),
          SizedBox(height: size * 0.12),
          CreateProfileButtons(onPressed1: () {}, onPressed2: () {}),
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
          content: Column(
            children: [
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.walletSuccessMessage,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.continueCheckingProfile,
                fontSize: 16,
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
