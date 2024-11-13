import 'package:flutter/material.dart';

class ScreenUtils {
  static bool isSmallScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return size.width < 420;
  }
}
