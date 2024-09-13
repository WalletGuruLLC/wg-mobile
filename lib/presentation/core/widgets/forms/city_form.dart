import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/widgets/base_form_field_modal.dart';

class CityForm extends StatelessWidget {
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  final bool enabled;
  const CityForm({
    super.key,
    required this.items,
    this.enabled = true,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String hintText = l10n.selectYourCity;

    return BaseFormFieldModal(
      initialValue: initialValue,
      enabled: enabled,
      readOnly: true,
      hintText: hintText,
      items: items,
      onChanged: onChanged,
      validator: (value, context) => Validators.validateEmpty(value, context),
    );
  }
}
