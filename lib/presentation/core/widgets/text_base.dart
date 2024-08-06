import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class TextBase extends StatelessWidget {
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextStyle? textStyle;

  const TextBase({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.maxLines = 3,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: textStyle?.copyWith(
            fontStyle: fontStyle,
            fontWeight: fontWeight,
            fontSize: fontSize,
            decoration: decoration,
            color: color ?? AppColorSchema.of(context).primaryText,
          ) ??
          GoogleFonts.inter(
            fontStyle: fontStyle,
            fontWeight: fontWeight,
            fontSize: fontSize,
            decoration: decoration,
            textStyle: TextStyle(
              color: color ?? AppColorSchema.of(context).primaryText,
            ),
          ),
    );
  }
}
