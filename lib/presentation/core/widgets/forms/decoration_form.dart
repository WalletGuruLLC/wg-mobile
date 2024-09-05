import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class CustomInputDecoration {
  final String hintText;

  CustomInputDecoration({required this.hintText});

  InputDecoration get decoration {
    return InputDecoration(
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
