import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class BaseTextFormField extends StatefulWidget {
  // Callback for handling changes to the input value.
  final void Function(String?, bool)? onChanged;

  // Function for validating the input value.
  final String? Function(String?, BuildContext)? validator;

  // List of input formatters for controlling the input format.
  final List<TextInputFormatter>? inputFormatters;

  // Defines the type of keyboard to display.
  final TextInputType? keyboardType;

  // Custom decoration for the text field.
  final InputDecoration? decoration;

  // Maximum and minimum lines for the text field.
  final int maxLines;
  final int? minLines;

  // Initial value for the text field.
  final String? initialValue;

  // Controls whether the text field is obscured (useful for passwords).
  final bool obscureText;

  // Callback triggered when the user submits the field.
  final void Function(String)? onFieldSubmitted;

  // Controls whether the text field is enabled.
  final bool enabled;

  // Controller for managing the text field's state.
  final TextEditingController? controller;

  // Maximum length for the input.
  final int? maxLength;

  // Alignment of the text within the field.
  final TextAlign textAlign;

  // Optional widget to be embedded in the text field.
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
  bool _touched = false;

  @override
  void initState() {
    super.initState();
    // Initialize the text controller and set up the initial value.
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue ?? '';
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    // Clean up the controller to avoid memory leaks.
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build the default decoration with customizable borders.
    InputDecoration defaultDecoration = _buildDefaultDecoration();
    return Material(
      child: TextFormField(
        style: GoogleFonts.lato(),
        textAlign: widget.textAlign,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        controller: _controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        // Apply the decoration, which can be customized or use the default.
        decoration: widget.decoration == null
            ? defaultDecoration
            : widget.decoration!.copyWith(
                border: widget.decoration?.border ?? defaultDecoration.border,
                enabledBorder: widget.decoration?.enabledBorder ??
                    defaultDecoration.enabledBorder,
                focusedBorder: widget.decoration?.focusedBorder ??
                    defaultDecoration.focusedBorder,
                errorBorder: widget.decoration?.errorBorder ??
                    defaultDecoration.errorBorder,
                focusedErrorBorder: widget.decoration?.focusedErrorBorder ??
                    defaultDecoration.focusedErrorBorder,
                errorText: _validator(_controller.text),
              ),
        validator: _validator,
        inputFormatters: widget.inputFormatters,
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }

  // Handle changes in the text field and trigger validation.
  void _onChanged() {
    setState(() {
      _touched = true;
      String value = _controller.text;
      if (widget.onChanged != null) widget.onChanged!(value, _isValid());
    });
  }

  // Check if the current input is valid based on the validator function.
  bool _isValid() => null == _validator(_controller.text);

  // Apply validation only if the field has been touched.
  String? _validator(String? value) {
    if (!_touched) return null;
    if (widget.validator == null) {
      return null;
    } else {
      return widget.validator!(value, context);
    }
  }

  // Build the default decoration, including border styling and error handling.
  InputDecoration _buildDefaultDecoration() {
    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.black, width: 1),
    );

    return InputDecoration(
      disabledBorder: defaultBorder,
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: defaultBorder.copyWith(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
      ),
      errorBorder: defaultBorder.copyWith(
        borderSide:
            BorderSide(color: AppColorSchema.of(context).errorColor, width: 1),
      ),
      focusedErrorBorder: defaultBorder.copyWith(
        borderSide:
            BorderSide(color: AppColorSchema.of(context).errorColor, width: 1),
      ),
      errorText: _validator(_controller.text),
      errorMaxLines: 4,
      contentPadding: const EdgeInsets.all(12.0),
    );
  }
}
