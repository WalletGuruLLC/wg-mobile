import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';

class BaseDropdown extends StatelessWidget {
  final bool enabled;
  final String? hintText;
  final String? initialValue;
  final List<String>? items;
  final Function(String?)? onChanged;
  final InputDecoration? decoration;
  final TextStyle? hintStyle;

  const BaseDropdown({
    super.key,
    this.hintText,
    this.initialValue,
    this.items,
    this.onChanged,
    this.decoration,
    this.hintStyle,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: Colors.grey[900],
      style: hintStyle,
      decoration: decoration,
      value: initialValue,
      items: items!.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: _buildItemText(value),
        );
      }).toList(),
      onChanged: enabled ? onChanged : null,
    );
  }

  Widget _buildItemText(String value) {
    return MarqueeText(
      speed: 10,
      text: TextSpan(text: value),
      style: const TextStyle(
        fontFamily: 'CenturyGothic',
        color: Colors.white,
      ),
    );
  }
}
