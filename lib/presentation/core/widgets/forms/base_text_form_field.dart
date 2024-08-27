import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class BaseTextFormField extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? Function(String?, BuildContext)? validator;
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
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final bool readOnly;

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
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    this.readOnly = false,
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
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      style: const TextStyle(
        fontFamily: 'CenturyGothic',
        color: Colors.white,
      ),
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: _controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: widget.decoration ?? defaultDecoration,
      validator: widget.validator != null
          ? (value) => widget.validator!(value, context)
          : null,
      inputFormatters: widget.inputFormatters,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged:
          widget.onChanged != null ? (value) => widget.onChanged!(value) : null,
    );
  }

  InputDecoration _buildDefaultDecoration() {
    final OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: Colors.grey[400]!,
        width: 1.5,
      ),
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
        borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
      ),
      hintText: widget.hintText,
      hintStyle: AppTextStyles.formText,
      errorBorder: errorBorder,
      errorMaxLines: 5,
      focusedErrorBorder: errorBorder,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 16.0), // Adjust padding
      suffixIcon: widget.suffixIcon,
    );
  }
}
