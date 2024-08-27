import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      onChanged: onChanged,
      decoration: CustomInputDecoration(hintText: hintText).decoration,
    );
  }
}
