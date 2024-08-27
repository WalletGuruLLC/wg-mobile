import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProfileButtons extends StatelessWidget {
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  const CreateProfileButtons(
      {super.key, required this.onPressed1, required this.onPressed2});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          border: Border.all(
              color: AppColorSchema.of(context).secondaryButtonBorderColor),
          color: Colors.transparent,
          text: l10n.back,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          onPressed: onPressed1,
          width: width * 0.40,
        ),
        CustomButton(
          border: Border.all(
              color: AppColorSchema.of(context).secondaryButtonBorderColor),
          color: Colors.transparent,
          text: l10n.next,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          width: width * 0.40,
          onPressed: onPressed2,
        ),
      ],
    );
  }
}
