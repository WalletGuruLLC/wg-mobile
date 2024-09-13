import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

class PhoneNumberForm extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final bool enabled;
  final bool allowNull;
  final Widget? fieldActivatorWidget;
  final bool readOnly;

  const PhoneNumberForm({
    super.key,
    required this.onChanged,
    this.initialValue,
    this.enabled = true,
    this.allowNull = false,
    this.fieldActivatorWidget,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BaseTextFormField(
      // enabled: enabled,
      readOnly: readOnly,
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      hintStyle: AppTextStyles.formText,
      decoration: CustomInputDecoration(
        hintText: l10n.enterPhoneNumber,
        //suffixIcon: fieldActivatorWidget,
      ).decoration,
      validator: (value, context) =>
          Validators.validatePhoneNumber(value, context),
      onChanged: onChanged,
      maxLength: 10,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
