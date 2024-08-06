import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/colors/app_colors.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/dark_color_schema.dart';

class AppColorSchema {
  static AppCustomColors of(BuildContext context) {
    // final Brightness brightnessValue =
    //     MediaQuery.of(context).platformBrightness;
    // final bool isDark = brightnessValue == Brightness.dark;

    // return isDark ? DarkColorScheme() : LightColorScheme();

    // force only use dark color scheme
    return DarkColorScheme();
  }
}
