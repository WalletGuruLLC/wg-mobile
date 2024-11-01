import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

class PasswordConfirmForm extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final String? passwordValue;
  final String? hintText;
  final bool enabled;
  final bool allowNull;
  final String? labelText;
  final bool? underDecoration;

  const PasswordConfirmForm({
    super.key,
    this.initialValue,
    this.passwordValue,
    this.hintText,
    this.enabled = true,
    required this.onChanged,
    this.labelText,
    this.allowNull = false,
    this.underDecoration = false,
  });

  @override
  State<PasswordConfirmForm> createState() => _PasswordConfirmFormState();
}

class _PasswordConfirmFormState extends State<PasswordConfirmForm> {
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
          validator: (value, context) => Validators.validateConfirmPassword(
            value,
            widget.passwordValue!,
            context,
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }

  Widget _buildSuffixIcon() {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: SizedBox(
          width: 10,
          height: 10,
          child: SvgPicture.asset(
            _obscureText ? Assets.openEye : Assets.closeEye,
            width: 10,
            height: 10,
          ),
        ),
      ),
    );
  }
}
