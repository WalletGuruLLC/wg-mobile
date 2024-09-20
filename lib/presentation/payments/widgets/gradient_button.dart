import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final String imageAsset;
  final Function() onTap;

  const GradientButton({
    super.key,
    required this.text,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final gradient = AppColorSchema.of(context).buttonGradientColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.90,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: gradient,
        ),
        child: Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: AppColorSchema.of(context).scaffoldColor,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageAsset,
                height: 30,
              ),
              SizedBox(
                width: 200,
                child: Center(
                  child: TextBase(
                    text: text,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
