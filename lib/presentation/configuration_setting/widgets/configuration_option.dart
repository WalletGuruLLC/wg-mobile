import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/configuration_setting/widgets/toggle.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class ConfigurationOption extends StatelessWidget {
  final String optionTitle;
  final bool? showToggle;
  final void Function()? onTap;

  const ConfigurationOption({
    super.key,
    required this.optionTitle,
    this.showToggle = false,
    this.onTap,
  });

  double _getFontSize(double width) {
    return width < 430 ? 14.5 : 16;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBase(
                text: optionTitle,
                fontSize: _getFontSize(size.width),
                color: AppColorSchema.of(context).configurationColor,
              ),
              if (showToggle == true)
                const ToggleSwitch()
              else
                Icon(
                  Icons.chevron_right_outlined,
                  color: AppColorSchema.of(context).configurationColor,
                ),
            ],
          ),
        ),
        Divider(height: size.height * .06, thickness: .5),
      ],
    );
  }
}
