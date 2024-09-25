import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class PetitionResponseModal extends StatelessWidget {
  final Locale locale;
  final bool isSuccessful;
  final void Function() onPressed;
  final String title;
  final String content;
  final String? errorCode;

  const PetitionResponseModal({
    super.key,
    required this.locale,
    required this.isSuccessful,
    required this.onPressed,
    required this.title,
    required this.content,
    this.errorCode,
  });

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return BaseModal(
      isSucefull: isSuccessful,
      buttonWidth: locale.languageCode == 'en'
          ? MediaQuery.of(context).size.width * 0.40
          : MediaQuery.of(context).size.width * 0.45,
      content: Column(
        children: [
          SizedBox(height: size * 0.010),
          TextBase(
            textAlign: TextAlign.center,
            text: title,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
          ),
          SizedBox(height: size * 0.010),
          TextBase(
            textAlign: TextAlign.center,
            text: content,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
          ),
          SizedBox(height: errorCode != null ? size * 0.010 : 0),
          if (errorCode != null)
            TextBase(
              textAlign: TextAlign.center,
              text: errorCode!,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColorSchema.of(context).secondaryText,
            ),
          SizedBox(height: errorCode != null ? size * 0.005 : 0),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
