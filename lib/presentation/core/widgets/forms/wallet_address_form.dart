import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/special_decoration.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class WalletAddressForm extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final bool enabled;
  final bool allowNull;
  final String? labelText;
  final TextEditingController? controller;
  final bool? specialDecoration;
  final bool? validation;
  final String? hintText;

  const WalletAddressForm({
    super.key,
    this.initialValue,
    this.enabled = true,
    required this.onChanged,
    this.labelText,
    this.allowNull = false,
    this.controller,
    this.specialDecoration = false,
    this.validation = true,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: AppTextStyles.formText,
          ),
        Container(
          margin: const EdgeInsets.all(1),
          decoration: specialDecoration == true
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.transparent,
                  ),
                  gradient: AppColorSchema.of(context).buttonGradientColor,
                )
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: AppColorSchema.of(context).scaffoldColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: BaseTextFormField(
              enabled: enabled,
              initialValue: initialValue,
              controller: controller,
              keyboardType: TextInputType.text,
              hintText: hintText ?? l10n.enterAddressName,
              hintStyle: AppTextStyles.formText,
              inputFormatters: [_LowerCamelCaseFormatter()],
              onChanged: onChanged,
              decoration: specialDecoration == true
                  ? SpecialDecoration(
                      hintText: l10n.enterAddressName,
                    ).decoration
                  : null,
              validator: validation == true
                  ? (value, context) =>
                      Validators.validateWalletAddress(value, context)
                  : null,
            ),
          ),
        )
      ],
    );
  }
}

class _LowerCamelCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.toLowerCase();

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
