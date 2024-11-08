import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

class SocialSecurityForm extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final bool enabled;
  final bool allowNull;
  final String? labelText;

  const SocialSecurityForm({
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
          keyboardType: TextInputType.number,
          hintStyle: AppTextStyles.formText,
          decoration: CustomInputDecoration(hintText: l10n.enterSSN).decoration,
          validator: (value, context) => Validators.validateSSN(value, context),
          onChanged: onChanged,
          inputFormatters: [SSNInputFormatter()],
          maxLength: 11,
        ),
      ],
    );
  }
}

class SSNInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Remove any non-digit characters
    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');

    // Format the digits into the SSN pattern
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 3 || i == 5) {
        buffer.write('-');
      }
      buffer.write(digitsOnly[i]);
    }

    final formattedText = buffer.toString();

    // Return the new formatted value
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
