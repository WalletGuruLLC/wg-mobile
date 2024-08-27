import 'package:flutter/material.dart';

String fontFamily = 'CenturyGothic';

class AppTextStyles {
  static final formText = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFFC6C6C6),
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static final title = TextStyle(
      fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.bold);
  static final titleXL = TextStyle(
      fontFamily: fontFamily, fontSize: 22, fontWeight: FontWeight.bold);
  static final subTitle = TextStyle(
      fontFamily: fontFamily, fontSize: 15, fontWeight: FontWeight.w600);
  static final heading = TextStyle(fontFamily: fontFamily, fontSize: 18);
  static final body = TextStyle(fontFamily: fontFamily, fontSize: 15);
  static final hint = TextStyle(fontFamily: fontFamily, fontSize: 13);
  static final specialFormText = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFFC6C6C6),
    fontSize: 22,
    fontWeight: FontWeight.w300,
  );
}
