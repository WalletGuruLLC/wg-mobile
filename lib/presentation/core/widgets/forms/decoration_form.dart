import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class CustomInputDecoration {
  final String hintText;

  CustomInputDecoration({required this.hintText});

  InputDecoration get decoration {
    return InputDecoration(
      counterText: '',
      hintText: hintText,
      hintStyle: AppTextStyles.specialFormText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }
}
