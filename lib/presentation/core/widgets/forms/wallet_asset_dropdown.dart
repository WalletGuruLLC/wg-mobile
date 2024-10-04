import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/input/input_border_style.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/base_form_field_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

class WalletAssetDropdown extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const WalletAssetDropdown({
    super.key,
    this.hintText,
    this.initialValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputBorderStyleWhite(
      child: BaseFormFieldModal(
        hintText: hintText,
        initialValue: initialValue,
        readOnly: true,
        items: items,
        onChanged: onChanged,
        decoration: CustomInputDecoration(hintText: hintText!).decoration,
        hintStyle: AppTextStyles.formText,
      ),
    );
  }
}
