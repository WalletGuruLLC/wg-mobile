import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class BaseModal extends StatelessWidget {
  final Widget? content;
  final double? widthFactor;
  final double? heightFactor;
  final double? borderRadius;
  final double? paddingValue;
  final Widget Function()? buildFooter;
  final double blurFactor;
  final Color? modalColor;
  final Widget? centerIcon;
  const BaseModal({
    super.key,
    this.content,
    this.widthFactor = 0.9,
    this.heightFactor = 0.40,
    this.borderRadius = 12,
    this.paddingValue = 20,
    this.buildFooter,
    this.blurFactor = 5.0,
    this.modalColor = const Color(0xFFFAFAFA),
    this.centerIcon,
  });
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurFactor,
          sigmaY: blurFactor,
        ),
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: Container(
            padding: EdgeInsets.all(paddingValue!),
            decoration: BoxDecoration(
              color: modalColor,
              borderRadius: BorderRadius.circular(borderRadius!),
              border: Border.all(color: Colors.black, width: 0),
            ),
            child: content != null
                ? Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        _buildCloseButton(context),
                        Center(child: content!),
                        if (buildFooter != null) buildFooter!(),
                      ],
                    ),
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width * 0.05,
        ),
        centerIcon == null
            ? Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: .5,
                    color: AppColorSchema.of(context).buttonColor,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: Icon(
                    Icons.check,
                    color: AppColorSchema.of(context).buttonColor,
                    size: 20,
                  ),
                ),
              )
            : centerIcon!,
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: .5, color: Colors.black),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Padding(
              padding: EdgeInsets.all(3.5),
              child: Icon(
                Icons.close,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
