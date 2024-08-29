import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../styles/text_styles/app_text_styles.dart';
import 'decoration_form.dart';
import 'dropdown_base.dart';

class StateForm extends StatelessWidget {
  final bool enabled;
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const StateForm({
    Key? key,
    this.enabled = true,
    this.initialValue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String? hintText = l10n.selectYourState;
    return BaseDropdown(
      enabled: enabled,
      hintText: hintText,
      items: items,
      onChanged: onChanged,
      decoration: CustomInputDecoration(hintText: hintText).decoration,
      hintStyle: AppTextStyles.formText,
    );
  }
}
