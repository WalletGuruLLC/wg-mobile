import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/dropdown_base.dart';

class IdentificationTypeDropForm extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const IdentificationTypeDropForm(
      {super.key,
      this.hintText,
      this.initialValue,
      required this.items,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return BaseDropdown(
      hintText: hintText,
      initialValue: initialValue,
      items: items,
      onChanged: onChanged,
      decoration: CustomInputDecoration(hintText: hintText!).decoration,
      hintStyle: AppTextStyles.formText,
    );
  }
}
