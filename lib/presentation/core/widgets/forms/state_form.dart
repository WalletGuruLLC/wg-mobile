import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/widgets/base_form_field_modal.dart';

class StateForm extends StatelessWidget {
  final bool enabled;
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const StateForm({
    super.key,
    this.enabled = true,
    this.initialValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String hintText = l10n.selectYourState;
    return BaseFormFieldModal(
      initialValue: initialValue,
      readOnly: true,
      enabled: enabled,
      hintText: hintText,
      items: items,
      onChanged: onChanged,
    );
  }
}
