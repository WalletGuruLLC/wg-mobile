import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

class IdentificationNumberForm extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final bool enabled;
  final bool allowNull;
  final String? labelText;

  const IdentificationNumberForm({
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
          keyboardType: TextInputType.text,
          hintStyle: AppTextStyles.formText,
          decoration:
              CustomInputDecoration(hintText: l10n.enterIdNumber).decoration,
          validator: (value, context) => Validators.validateName(value),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
