import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/styles/input/input_border_style.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/special_decoration.dart';

class AmountForm extends StatelessWidget {
  final void Function(String?)? onChanged;
  final bool allowNull;
  final TextEditingController? controller;

  const AmountForm({
    super.key,
    required this.onChanged,
    this.allowNull = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputBorderStyle(
          child: BaseTextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            hintText: l10n.enterAmount,
            hintStyle: AppTextStyles.formText,
            onChanged: (value) {
              controller?.value = TextEditingValue(
                text: value!,
                selection: TextSelection.collapsed(offset: value.length),
              );
              if (onChanged != null) {
                onChanged!(value);
              }
            },
            decoration: SpecialDecoration(
              hintText: l10n.enterAmount,
              prefixText: '\$',
              prefixStyle: const TextStyle(color: Colors.white),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            ).decoration,
          ),
        ),
      ],
    );
  }
}
