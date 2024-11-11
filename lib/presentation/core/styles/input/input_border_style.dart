import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class InputBorderStyle extends StatelessWidget {
  final Widget child;
  final bool? showWhiteBorder;
  const InputBorderStyle({
    super.key,
    required this.child,
    this.showWhiteBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.0,
          color: showWhiteBorder! ? Colors.white : Colors.transparent,
        ),
        gradient: showWhiteBorder!
            ? null
            : AppColorSchema.of(context).buttonGradientColor,
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

class InputBorderStyleWhite extends StatelessWidget {
  final Widget child;
  const InputBorderStyleWhite({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          width: 1.5,
          color: Colors.grey[400]!,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColorSchema.of(context).scaffoldColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: child,
      ),
    );
  }
}

class InputBorderStyle2 extends StatelessWidget {
  final Widget child;
  final bool? showWhiteBorder;
  const InputBorderStyle2({
    super.key,
    required this.child,
    this.showWhiteBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.0,
          color: showWhiteBorder! ? Colors.white : Colors.transparent,
        ),
        gradient: showWhiteBorder!
            ? null
            : AppColorSchema.of(context).buttonGradientColor,
      ),
      child: Container(
          padding: const EdgeInsets.only(left: 20.0, top: 5.0),
          decoration: BoxDecoration(
            color: AppColorSchema.of(context).scaffoldColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: child),
    );
  }
}
