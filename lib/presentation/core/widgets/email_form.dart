import 'package:flutter/material.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'base_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailForm extends StatelessWidget {
  final void Function(String?, bool)? onChanged;
  final String? initialValue;
  final bool enabled;
  final bool allowNull;
  final String? labelText;

  const EmailForm({
    super.key,
    this.initialValue,
    this.enabled = true,
    required this.onChanged,
    this.labelText,
    this.allowNull = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: AppTextStyles.formText,
          ),
        BaseTextFormField(
          enabled: enabled,
          initialValue: initialValue,
          maxLength: 10,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.email,
            hintStyle: AppTextStyles.formText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          validator: (value, context) => Validators.validatePhoneNumber(value),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
