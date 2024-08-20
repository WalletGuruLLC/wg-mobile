import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class WalletAddressForm extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final String? hintText;
  final bool enabled;
  final bool allowNull;
  final String? labelText;

  const WalletAddressForm({
    super.key,
    this.initialValue,
    this.hintText,
    this.enabled = true,
    required this.onChanged,
    this.labelText,
    this.allowNull = false,
  });

  @override
  State<WalletAddressForm> createState() => _WalletAddressFormState();
}

class _WalletAddressFormState extends State<WalletAddressForm> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: AppTextStyles.formText,
          ),
        BaseTextFormField(
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          keyboardType: TextInputType.text,
          hintText: l10n.enterAddressName,
          hintStyle: AppTextStyles.formText,
          onChanged: widget.onChanged,
          validator: (value, context) => Validators.validateAddress(value),
        ),
      ],
    );
  }
}
