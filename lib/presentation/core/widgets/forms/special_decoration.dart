import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class SpecialDecoration {
  final String hintText;
  final Widget? suffixIcon;

  SpecialDecoration({required this.hintText, this.suffixIcon});

  InputDecoration get decoration {
    return InputDecoration(
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
