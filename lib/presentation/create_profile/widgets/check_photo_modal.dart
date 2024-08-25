import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckPhotoModal extends StatelessWidget {
  final Uint8List image;

  const CheckPhotoModal({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return BaseModal(
      showCloseIcon: true,
      centerIcon: Container(),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          TextBase(
            text: l10n.picturePreview,
            fontSize: 20,
            color: AppColorSchema.of(context).secondaryText,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 20),
          ClipOval(
            child: Image.memory(
              image,
              width: size.width * 0.6,
              height: size.width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                borderRadius: 12,
                width: size.width * 0.3,
                border: Border.all(
                  color: AppColorSchema.of(context).secondaryButtonBorderColor,
                ),
                color: AppColorSchema.of(context).buttonColor,
                text: l10n.allow,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                onPressed: () {},
              ),
              CustomButton(
                borderRadius: 12,
                width: size.width * 0.3,
                border: Border.all(
                  color: AppColorSchema.of(context).secondaryButtonBorderColor,
                ),
                color: AppColorSchema.of(context).clearButtonColor,
                text: l10n.deny,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                buttonTextColor: Colors.black,
                onPressed: () => Navigator.of(context).pop(), // Close the modal
              ),
            ],
          ),
        ],
      ),
    );
  }
}
