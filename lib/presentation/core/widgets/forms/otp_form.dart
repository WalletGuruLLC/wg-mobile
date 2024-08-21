import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class OtpForm extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final String? hintText;
  final bool enabled;
  final bool allowNull;
  final String? labelText;

  const OtpForm({
    super.key,
    this.initialValue,
    this.hintText,
    this.enabled = true,
    required this.onChanged,
    this.labelText,
    this.allowNull = false,
  });

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
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
          hintText: widget.hintText ?? l10n.enter_auth_code,
          hintStyle: AppTextStyles.formText,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
