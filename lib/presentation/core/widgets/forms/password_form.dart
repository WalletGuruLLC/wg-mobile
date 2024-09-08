import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

class PasswordForm extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final String? hintText;
  final bool enabled;
  final bool allowNull;
  final String? labelText;
  final bool? underDecoration;

  const PasswordForm({
    super.key,
    this.initialValue,
    this.hintText,
    this.enabled = true,
    required this.onChanged,
    this.labelText,
    this.allowNull = false,
    this.underDecoration = false,
  });

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          hintText: widget.hintText ?? l10n.password,
          hintStyle: AppTextStyles.formText,
          decoration: !widget.underDecoration!
              ? null
              : CustomInputDecoration(
                  hintText: widget.hintText!,
                  suffixIcon: _buildSuffixIcon(),
                ).decoration,
          suffixIcon: !widget.underDecoration! ? _buildSuffixIcon() : null,
          validator: (value, context) =>
              Validators.validatePassword(value, context),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }

  Widget _buildSuffixIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Image.asset(
        _obscureText ? Assets.passwordLogo : Assets.viewPasswordLogo,
        width: 20,
        height: 20,
      ),
    );
  }
}
