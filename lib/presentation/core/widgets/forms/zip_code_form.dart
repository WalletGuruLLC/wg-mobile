import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';

class ZipCodeForm extends StatelessWidget {
  final bool enabled;
  final void Function(String?)? onChanged;
  final String? initialValue;

  const ZipCodeForm({
    super.key,
    this.enabled = true,
    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String hintText = l10n.enterYourZipCode;

    return BaseTextFormField(
      enabled: enabled,
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      hintStyle: AppTextStyles.formText,
      decoration: CustomInputDecoration(hintText: hintText).decoration,
      validator: (value, context) => Validators.validateZipCode(value, context),
      onChanged: onChanged,
    );
  }
}
