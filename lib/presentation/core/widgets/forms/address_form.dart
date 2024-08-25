import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

class AddressForm extends StatelessWidget {
  final bool enabled;
  final String? initialValue;
  final void Function(String?)? onChanged;

  const AddressForm({
    super.key,
    this.enabled = true,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String hintText = l10n.enterYourAddress;

    return BaseTextFormField(
      enabled: enabled,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: CustomInputDecoration(hintText: hintText).decoration,
    );
  }
}
