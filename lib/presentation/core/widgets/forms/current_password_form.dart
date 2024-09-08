import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';

class CurrentPasswordForm extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final String? hintText;
  final bool enabled;
  final bool allowNull;
  final String? labelText;

  const CurrentPasswordForm({
    super.key,
    this.initialValue,
    this.hintText,
    this.enabled = true,
    required this.onChanged,
    this.labelText,
    this.allowNull = false,
  });

  @override
  State<CurrentPasswordForm> createState() => _CurrentPasswordFormState();
}

class _CurrentPasswordFormState extends State<CurrentPasswordForm> {
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
          hintText: widget.hintText ?? l10n.password,
          hintStyle: AppTextStyles.formText,
          decoration: CustomInputDecoration(
            hintText: widget.hintText!,
          ).decoration,
          validator: (value, context) =>
              Validators.validatePassword(value, context),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
