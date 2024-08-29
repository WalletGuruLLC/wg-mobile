import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/dynamic_container.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class BaseModal extends StatelessWidget {
  final Widget? content;
  final double? widthFactor;
  final double? heightFactor;
  final double? borderRadius;
  final double? paddingValue;
  final bool? isFail;
  final Widget Function()? buildFooter;
  final void Function()? onPressed;
  final double blurFactor;
  final Color? modalColor;
  final Widget? centerIcon;
  final bool? showCloseIcon;
  final double? buttonWidth;
  const BaseModal({
    super.key,
    this.content,
    this.widthFactor = 0.9,
    this.heightFactor = 0.26,
    this.borderRadius = 12,
    this.paddingValue = 20,
    this.isFail = false,
    this.buildFooter,
    this.onPressed,
    this.blurFactor = 5.0,
    this.modalColor = const Color(0xFFFAFAFA),
    this.centerIcon,
    this.showCloseIcon = true,
    this.buttonWidth,
  });
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurFactor,
          sigmaY: blurFactor,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width *
                    0.05), // 5% en each side
            child: DynamicContainer(
              // DynamicContainer is a custom widget to handle responsive design
              children: [
                Container(
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
                              Icon(
                                isFail!
                                    ? Icons.warning_amber_sharp
                                    : Icons.check_circle_outline,
                                color: AppColorSchema.of(context).buttonColor,
                              ),
                              Center(child: content!),
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  CustomButton(
                                    width: buttonWidth,
                                    border: Border.all(
                                        color: AppColorSchema.of(context)
                                            .buttonBorderColor),
                                    text: isFail!
                                        ? l10n.button_pop_up_fail
                                        : l10n.button_pop_up_sucefull,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    onPressed: onPressed,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
