import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseDropdown extends StatelessWidget {
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
      onChanged: onChanged,
    );
  }

  Widget _buildItemText(String value) {
    return Text(
      value,
      style: GoogleFonts.lato(
        color: Colors.white,
      ),
    );
  }
}
