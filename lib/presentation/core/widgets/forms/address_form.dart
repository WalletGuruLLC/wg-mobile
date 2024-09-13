import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';

class AddressForm extends StatelessWidget {
  final bool enabled;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final bool readOnly;
  final Widget? fieldActivatorWidget;

  const AddressForm({
    super.key,
    this.enabled = true,
    this.initialValue,
    this.onChanged,
    this.readOnly = false,
    this.fieldActivatorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String hintText = l10n.enterYourAddress;

    return BaseTextFormField(
      readOnly: readOnly,
      enabled: enabled,
      initialValue: initialValue,
      keyboardType: TextInputType.text,
      hintStyle: AppTextStyles.formText,
      decoration: CustomInputDecoration(
        hintText: hintText,
      ).decoration,
      validator: (value, context) => Validators.validateAddress(value, context),
      onChanged: onChanged,
    );
  }
}
