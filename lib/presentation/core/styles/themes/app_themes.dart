import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/colors/app_colors.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class AppThemes {
  static ThemeData lightTheme(AppCustomColors colors) => ThemeData(
        brightness: Brightness.light,
        cardColor: colors.cardColor,
        dialogBackgroundColor: colors.cardColor,
        appBarTheme: AppBarTheme(
          backgroundColor: colors.cardColor,
          iconTheme: IconThemeData(color: colors.primary),
          titleTextStyle: AppTextStyles.title.copyWith(color: colors.primary),
        ),
        scaffoldBackgroundColor: colors.scaffoldColor,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: colors.inputColor,
          labelStyle: TextStyle(color: colors.primary),
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.title.copyWith(color: colors.primaryText),
          displayMedium:
              AppTextStyles.heading.copyWith(color: colors.primaryText),
          displaySmall: AppTextStyles.body.copyWith(color: colors.primaryText),
          headlineMedium:
              AppTextStyles.hint.copyWith(color: colors.primaryText),
        ),
        bottomAppBarTheme: BottomAppBarTheme(color: colors.cardColor),
      );

  static ThemeData darkTheme(AppCustomColors colors) => ThemeData(
        brightness: Brightness.dark,
        cardColor: colors.cardColor,
        dialogBackgroundColor: colors.cardColor,
        appBarTheme: AppBarTheme(
          backgroundColor: colors.scaffoldColor,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: AppTextStyles.title.copyWith(color: Colors.white),
        ),
        scaffoldBackgroundColor: colors.scaffoldColor,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: colors.inputColor,
          labelStyle: const TextStyle(color: Colors.white),
        ),
        textTheme: TextTheme(
          displayLarge: AppTextStyles.title.copyWith(color: colors.primaryText),
          displayMedium:
              AppTextStyles.heading.copyWith(color: colors.primaryText),
          displaySmall: AppTextStyles.body.copyWith(color: colors.primaryText),
          headlineMedium:
              AppTextStyles.hint.copyWith(color: colors.primaryText),
        ),
        bottomAppBarTheme: BottomAppBarTheme(color: colors.scaffoldColor),
      );
}
