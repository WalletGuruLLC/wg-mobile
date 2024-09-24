import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class ToggleSwitch extends StatefulWidget {
  const ToggleSwitch({super.key});

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isActive,
      onChanged: (value) {
        setState(() {
          isActive = value;
        });
        // ignore: avoid_print
        print(value);
      },
      activeColor: AppColorSchema.of(context).tertiaryText,
      activeTrackColor: AppColorSchema.of(context).primaryText,
      inactiveThumbColor: AppColorSchema.of(context).configurationColor,
      inactiveTrackColor: AppColorSchema.of(context).primaryText,
    );
  }
}
