import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class SpecialDecoration {
  final String hintText;
  final Widget? suffixIcon;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final EdgeInsets? contentPadding;

  SpecialDecoration(
      {required this.hintText,
      this.suffixIcon,
      this.prefixText,
      this.prefixStyle,
      this.contentPadding});

  InputDecoration get decoration {
    return InputDecoration(
      prefixText: prefixText,
      suffixIcon: suffixIcon,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 1.0,
          style: BorderStyle.solid,
          color: Colors.transparent,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 1.0,
          style: BorderStyle.solid,
          color: Colors.transparent,
        ),
      ),
      hintText: hintText,
      fillColor: Colors.transparent,
      hintStyle: AppTextStyles.specialFormText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorMaxLines: 5,
    );
  }
}
