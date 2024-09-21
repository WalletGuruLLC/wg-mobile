import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/dynamic_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class HideNotificationModal extends StatefulWidget {
  const HideNotificationModal({super.key});

  @override
  State<HideNotificationModal> createState() => _HideNotificationModalState();
}

class _HideNotificationModalState extends State<HideNotificationModal> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: DynamicContainer(
              // DynamicContainer es un widget personalizado para manejar el diseño responsivo
              children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 0),
                    ),
                    child: Material(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Close button
                        _buildModalTitle(l10n, context),
                        const SizedBox(height: 10),
                        // Instruction Text
                        _buildModalInformation(l10n),
                        const SizedBox(height: 20),
                        // Radio options
                        Column(
                          children: [
                            _buildCustomRadioTile(
                              title: l10n.thirtyMin,
                              value: 0,
                              context: context,
                            ),
                            _buildCustomRadioTile(
                              title: l10n.oneHour,
                              value: 1,
                              context: context,
                            ),
                            _buildCustomRadioTile(
                              title: l10n.never,
                              value: 2,
                              context: context,
                            ),
                          ],
                        ),
                      ],
                    ))),
              ]),
        ),
      ),
    );
  }

  Widget _buildCustomRadioTile(
      {required String title,
      required int value,
      required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextBase(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        Transform.scale(
          scale: 1.2, // Aumentar tamaño de la bolita
          child: Radio<int>(
            value: value,
            groupValue: _selectedValue,
            onChanged: (newValue) {
              setState(() {
                _selectedValue = newValue;
              });
            },
            activeColor: AppColorSchema.of(context).tertiaryText,
          ),
        ),
      ],
    );
  }

  TextBase _buildModalInformation(AppLocalizations l10n) {
    return TextBase(
      text: l10n.hideNotificationModalText,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  Row _buildModalTitle(AppLocalizations l10n, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextBase(
          text: l10n.hideNotification,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
            Assets.closeIcon,
            height: 30,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
