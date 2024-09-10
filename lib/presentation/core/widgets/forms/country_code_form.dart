import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/dropdown_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountryCodeForm extends StatelessWidget {
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const CountryCodeForm({
    super.key,
    required this.items,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String hintText = l10n.selectYourCountryCode;

    return BaseDropdown(
      initialValue: initialValue,
      width: 80,
      hintText: hintText,
      items: items,
      onChanged: onChanged,
      decoration: CustomInputDecoration(hintText: hintText).decoration,
      hintStyle: AppTextStyles.formText,
    );
  }
}
