import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/dynamic_container.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool isAppColor;
  final Border? border;
  final Color? color;
  final Color? buttonTextColor;
  final FontWeight? fontWeight;
  final Widget? widget;
  final Icon? iconWidget;
  final bool isModal;

  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    required this.onPressed,
    this.text,
    this.isAppColor = true,
    this.fontSize,
    this.border,
    this.color,
    this.buttonTextColor,
    this.fontWeight,
    this.widget,
    this.iconWidget,
    this.isModal = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonContent = widget ??
        (iconWidget == null
            ? TextBase(
                text: text,
                fontWeight: fontWeight ?? FontWeight.w600,
                fontSize: fontSize ?? 17.5,
                color: buttonTextColor ??
                    AppColorSchema.of(context).buttonTextColor,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconWidget!,
                  const SizedBox(
                    width: 10,
                  ),
                  TextBase(
                    text: text,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize ?? 17.5,
                    color: buttonTextColor ?? Colors.black,
                  ),
                  const SizedBox(width: 1),
                ],
              ));

    final button = Container(
      decoration: BoxDecoration(
        color: color ??
            (isAppColor
                ? AppColorSchema.of(context).buttonColor
                : Colors.transparent),
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border: border ?? (isAppColor ? null : Border.all(color: Colors.black)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          elevation: 0.0,
        ),
        onPressed: onPressed,
        child: buttonContent,
      ),
    );

    if (isModal) {
      return DynamicContainer(
        minWidth: width,
        minHeight: height ?? 50,
        children: [button],
      );
    }

    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50,
      child: button,
    );
  }
}
