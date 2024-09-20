import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
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
        Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.0,
              color: Colors.transparent,
            ),
            gradient: AppColorSchema.of(context).buttonGradientColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColorSchema.of(context).scaffoldColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: BaseTextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                hintText: l10n.enterAmount,
                hintStyle: AppTextStyles.formText,
                onChanged: onChanged,
                decoration: SpecialDecoration(
                  hintText: l10n.enterAddressName,
                ).decoration),
          ),
        )
      ],
    );
  }
}
