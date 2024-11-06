import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/special_decoration.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';

class WalletAddressForm extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;
  final bool enabled;
  final bool allowNull;
  final String? labelText;
  final TextEditingController? controller;
  final bool? specialDecoration;
  final bool? validation;
  final String? hintText;

  const WalletAddressForm({
    super.key,
    this.initialValue,
    this.enabled = true,
    required this.onChanged,
    this.labelText,
    this.allowNull = false,
    this.controller,
    this.specialDecoration = false,
    this.validation = true,
    this.hintText,
  });

  @override
  State<WalletAddressForm> createState() => _WalletAddressFormState();
}

class _WalletAddressFormState extends State<WalletAddressForm> {
  late TextEditingController _controller;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _initializeController();
  }

  void _initializeController() {
    if (widget.initialValue != null && _controller.text.isEmpty) {
      _controller.text = widget.initialValue!.toLowerCase();
    }
    _controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    if (_disposed) return;

    final String currentText = _controller.text;
    final String lowerText = currentText.toLowerCase();

    if ((currentText != lowerText || currentText == lowerText) && mounted) {
      final int currentPosition = _controller.selection.base.offset;
      _controller.value = TextEditingValue(
        text: lowerText,
        selection: TextSelection.collapsed(
          offset: currentPosition,
        ),
      );
      widget.onChanged?.call(lowerText);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    if (widget.controller == null) {
      _controller.removeListener(_handleTextChange);
      _controller.dispose();
    }
    super.dispose();
  }

  /*@override
  void didUpdateWidget(WalletAddressForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _initializeController();
    }
  }*/

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
        Container(
          margin: const EdgeInsets.all(1),
          decoration: widget.specialDecoration == true
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.transparent,
                  ),
                  gradient: AppColorSchema.of(context).buttonGradientColor,
                )
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: AppColorSchema.of(context).scaffoldColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: BaseTextFormField(
              enabled: widget.enabled,
              controller: _controller,
              keyboardType: TextInputType.text,
              hintText: widget.hintText ?? l10n.enterAddressName,
              hintStyle: AppTextStyles.formText,
              decoration: widget.specialDecoration == true
                  ? SpecialDecoration(
                      hintText: l10n.enterAddressName,
                    ).decoration
                  : null,
              validator: widget.validation == true
                  ? (value, context) =>
                      Validators.validateWalletAddress(value, context)
                  : null,
            ),
          ),
        )
      ],
    );
  }
}
