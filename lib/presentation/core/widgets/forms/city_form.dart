import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'decoration_form.dart';
import 'dropdown_base.dart';

class CityForm extends StatelessWidget {
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const CityForm({
    super.key,
    required this.items,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String hintText = l10n.selectYourCity;

    return BaseDropdown(
      hintText: hintText,
      items: items,
      onChanged: onChanged,
      decoration: CustomInputDecoration(hintText: hintText).decoration,
      hintStyle: AppTextStyles.formText,
    );
  }
}
