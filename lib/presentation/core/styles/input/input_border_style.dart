import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class InputBorderStyle extends StatelessWidget {
  final Widget child;
  const InputBorderStyle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.0,
          color: Colors.transparent,
        ),
        gradient: AppColorSchema.of(context).buttonGradientColor,
      ),
      child: Container(
          decoration: BoxDecoration(
            color: AppColorSchema.of(context).scaffoldColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: child),
    );
  }
}
