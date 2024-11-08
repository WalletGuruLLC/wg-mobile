import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/input/input_border_style.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/base_form_field_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/create_wallet/create_wallet_cubit.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';

class WalletAssetDropdown extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;

  const WalletAssetDropdown({
    super.key,
    this.hintText,
    this.initialValue,
    required this.items,
    required this.onChanged,
  });

  @override
  State<WalletAssetDropdown> createState() => _WalletAssetDropdownState();
}

class _WalletAssetDropdownState extends State<WalletAssetDropdown> {
  @override
  void initState() {
    super.initState();
    // Llamar a onChanged con el valor inicial
    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChanged(widget.initialValue);
        BlocProvider.of<CreateWalletCubit>(context)
            .setAssetId(widget.initialValue!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: null,
      child: Container(
        decoration: BoxDecoration(
          color: AppColorSchema.of(context).scaffoldColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: BaseTextFormField(
          enabled: false,
          initialValue: widget.initialValue,
          keyboardType: TextInputType.number,
          hintStyle: AppTextStyles.formText,
        ),
      ),
    );
  }
}

class WalletAssetDropdown2 extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const WalletAssetDropdown2({
    super.key,
    this.hintText,
    this.initialValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputBorderStyleWhite(
      child: BaseFormFieldModal(
        hintText: hintText,
        initialValue: initialValue,
        readOnly: true,
        items: items,
        onChanged: onChanged,
        decoration: CustomInputDecoration(hintText: hintText!).decoration,
        hintStyle: AppTextStyles.formText,
      ),
    );
  }
}
