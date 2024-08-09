import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final formText = GoogleFonts.lato(
    color: const Color(0xFFC6C6C6),
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static final title =
      GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold);
  static final titleXL =
      GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold);
  static final subTitle =
      GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w600);
  static final heading = GoogleFonts.lato(fontSize: 18);
  static final body = GoogleFonts.lato(fontSize: 15);
  static final hint = GoogleFonts.lato(fontSize: 13);
}
