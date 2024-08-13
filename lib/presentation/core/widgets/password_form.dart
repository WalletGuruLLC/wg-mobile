import 'package:flutter/material.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'base_text_form_field.dart';

class PasswordForm extends StatefulWidget {
  final void Function(String?, bool)? onChanged;
  final String? initialValue;
  final bool enabled;
  final bool allowNull;
  final String? labelText;

  const PasswordForm({
    super.key,
    this.initialValue,
    this.enabled = true,
    required this.onChanged,
    this.labelText,
    this.allowNull = false,
  });

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.grey[400]!,
        width: 1.5,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: AppTextStyles.formText,
          ),
        BaseTextFormField(
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          keyboardType: TextInputType.text,
          obscureText: _obscureText,
          hintText: 'Password',
          hintStyle: AppTextStyles.formText,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              color: Colors.grey,
            ),
          ),
          validator: (value, context) => Validators.validatePassword(value),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
