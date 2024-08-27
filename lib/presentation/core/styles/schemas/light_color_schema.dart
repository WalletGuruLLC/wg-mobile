import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/colors/app_colors.dart';

class LightColorSchema implements AppCustomColors {
  @override
  Color get primary => const Color(0xFF1DA1F2);

  @override
  Color get secondary => const Color(0xFF2D2D2D);

  @override
  Color get terciary => const Color(0xFF3D3D3D);

  @override
  Color get accent => const Color(0xFF4D4D4D);

  @override
  Color get scaffoldColor => const Color(0xFF171717);

  @override
  Color get cardColor => const Color(0xFF222222);

  @override
  Color get inputColor => const Color(0xFF222222);

  @override
  Color get primaryText => const Color(0xFFFFFFFF);

  @override
  Color get secondaryText => const Color(0xFF232020);

  @override
  Color get tertiaryText => const Color(0xFF3678B1);

  @override
  Color get accentText => const Color(0xFFFFFFFF);

  @override
  Color get lightText => const Color(0xFFFFFFFF);

  @override
  Color get darkText => const Color(0xFF344054);

  @override
  Color get errorText => const Color(0xFFF04438);

  @override
  Color get successText => const Color(0xFF067647);

  @override
  Color get buttonColor => const Color(0xFF1DA1F2);

  @override
  Color get buttonTextColor => const Color(0xFFFFFFFF);

  @override
  Color get disabledButtonColor => const Color(0xFFF2F4F7);

  @override
  Color get disabledButtonTextColor => const Color(0xFF98A2B3);

  @override
  Color get primaryIcon => const Color(0xFFFFFFFF);

  @override
  Color get secondaryIcon => const Color(0xFF1DA1F2);

  @override
  Color get shadowCardColor => const Color(0x00000000);

  @override
  Color get headerBackgroundColor => const Color(0xFF171717);

  @override
  Color get headerActionsBackgroundColor => const Color(0xFF171717);

  @override
  Color get alertLink => const Color(0xFFF97066);

  @override
  Color get alertBorder => const Color(0xFFF04438);

  @override
  Color get clearButtonColor => const Color(0xFFEBEBEB);

  @override
  Color get modalBarrierColor => Colors.white24;

  @override
  Color get circleIconColor => const Color(0xFFE0F0FF);

  @override
  Color get avatarBorder => const Color(0xff9DE8A9);

  @override
  Color get cardBackgroundColor => const Color(0xFF292929);

  @override
  LinearGradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF171717), Color(0xFF171717)],
      );
  @override
  Color get errorColor => const Color(0xFFFF0000);

  @override
  Color get lineColor => const Color(0xFF00B0FB);

  @override
  Color get buttonBorderColor => const Color(0xFF3C93BE);

  @override
  Color get secondaryButtonBorderColor => const Color(0xFFDDDDDD);

  @override
  Color get modalPrincipalColor => const Color(0xFFFAFAFA);
}
