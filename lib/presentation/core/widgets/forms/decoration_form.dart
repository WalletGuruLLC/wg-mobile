import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class CustomInputDecoration {
  final String hintText;
  final Widget? suffixIcon;

  CustomInputDecoration({required this.hintText, this.suffixIcon});

  InputDecoration get decoration {
    return InputDecoration(
        suffixIcon: suffixIcon,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFF494949),
        )),
        counterText: '',
        hintText: hintText,
        fillColor: Colors.transparent,
        hintStyle: AppTextStyles.specialFormText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorMaxLines: 5);
  }
}
