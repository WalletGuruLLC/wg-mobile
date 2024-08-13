import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class BaseTextFormField extends StatefulWidget {
  final void Function(String?, bool)? onChanged;
  final String? Function(String?, BuildContext)?
      validator; // Keep the validator type
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final int maxLines;
  final int? minLines;
  final String? initialValue;
  final bool obscureText;
  final void Function(String)? onFieldSubmitted;
  final bool enabled;
  final TextEditingController? controller;
  final int? maxLength;
  final TextAlign textAlign;
  final Widget? widget;

  const BaseTextFormField({
    super.key,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.decoration,
    this.maxLines = 1,
    this.minLines,
    this.initialValue,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.enabled = true,
    this.controller,
    this.widget,
    this.maxLength,
    this.textAlign = TextAlign.start,
  });

  @override
  State<BaseTextFormField> createState() => _BaseTextFormField();
}

class _BaseTextFormField extends State<BaseTextFormField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration defaultDecoration = _buildDefaultDecoration();
    return TextFormField(
      style: GoogleFonts.lato(color: Colors.white),
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: _controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: widget.decoration ?? defaultDecoration,
      validator: widget.validator != null
          ? (value) => widget.validator!(value, context)
          : null, // Pass context when calling validator
      inputFormatters: widget.inputFormatters,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged != null
          ? (value) => widget.onChanged!(value, _isValid())
          : null,
    );
  }

  bool _isValid() => null == widget.validator?.call(_controller.text, context);

  InputDecoration _buildDefaultDecoration() {
    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0), // Rounded corners
      borderSide: BorderSide(
          color: Colors.grey[400]!, width: 1.5), // Default border color
    );

    OutlineInputBorder errorBorder = defaultBorder.copyWith(
      borderSide: BorderSide(
          color: AppColorSchema.of(context).errorColor,
          width: 1.5), // Error border color
    );

    return InputDecoration(
      disabledBorder: defaultBorder,
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: defaultBorder.copyWith(
        borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5), // Focused border color
      ),
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 16.0), // Adjust padding
      suffixIcon: Icon(Icons.person_outline, color: Colors.grey[400]),
    );
  }
}
