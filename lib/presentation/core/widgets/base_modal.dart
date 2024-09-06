import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/dynamic_container.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

import '../assets/assets.dart';

class BaseModal extends StatelessWidget {
  final Widget? content;
  final double? widthFactor;
  final double? heightFactor;
  final double? borderRadius;
  final double? paddingValue;
  final bool? isSucefull;
  final Widget Function()? buildFooter;
  final void Function()? onPressed;
  final double blurFactor;
  final Color? modalColor;
  final Widget? centerIcon;
  final bool? showCloseIcon;
  final double? buttonWidth;
  final bool hasActions;
  final bool hasCloseAction;

  const BaseModal({
    super.key,
    this.content,
    this.widthFactor = 0.9,
    this.heightFactor = 0.26,
    this.borderRadius = 12,
    this.paddingValue = 20,
    this.isSucefull = false,
    this.buildFooter,
    this.onPressed,
    this.blurFactor = 5.0,
    this.modalColor = const Color(0xFFFAFAFA),
    this.centerIcon,
    this.showCloseIcon = true,
    this.buttonWidth,
    this.hasActions = true,
    this.hasCloseAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurFactor,
        sigmaY: blurFactor,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: DynamicContainer(
            // DynamicContainer es un widget personalizado para maneßjar el diseño responsivo
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
                            if (hasCloseAction) _buildCloseButton(context),
                            if (hasActions)
                              Icon(
                                isSucefull!
                                    ? Icons.check_circle_outline
                                    : Icons.warning_amber_sharp,
                                color: AppColorSchema.of(context).buttonColor,
                              ),
                            Center(child: content!),
                            if (hasActions)
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  CustomButton(
                                    width: buttonWidth,
                                    border: Border.all(
                                        color: AppColorSchema.of(context)
                                            .buttonBorderColor),
                                    text: isSucefull!
                                        ? l10n.button_pop_up_sucefull
                                        : l10n.button_pop_up_fail,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    onPressed: onPressed,
                                  ),
                                ],
                              )
                          ],
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: SvgPicture.asset(
          Assets.closeIcon,
          height: 30,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
