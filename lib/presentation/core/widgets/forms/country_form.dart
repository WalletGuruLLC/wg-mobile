import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/widgets/base_form_field_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountryForm extends StatelessWidget {
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const CountryForm({
    super.key,
    required this.items,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String hintText = l10n.selectYourCountry;

    return BaseFormFieldModal(
      initialValue: initialValue,
      readOnly: true,
      hintText: hintText,
      items: items,
      onChanged: onChanged,
    );
  }
}
