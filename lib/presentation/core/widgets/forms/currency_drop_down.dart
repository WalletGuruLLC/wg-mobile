import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/presentation/core/styles/input/input_border_style.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/base_form_field_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/base_text_form_field.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/decoration_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/special_decoration.dart';

class CurrencyDropDown extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const CurrencyDropDown({
    super.key,
    this.hintText,
    this.initialValue,
    required this.items,
    required this.onChanged,
  });

  @override
  State<CurrencyDropDown> createState() => _CurrencyDropDownState();
}

class _CurrencyDropDownState extends State<CurrencyDropDown> {
  @override
  void initState() {
    super.initState();
    // Llamar a onChanged con el valor inicial
    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChanged(widget.initialValue);
        BlocProvider.of<SendPaymentCubit>(context)
            .updateSendPaymentInformation(currency: widget.initialValue!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InputBorderStyle2(
      child: BaseTextFormField(
        enabled: false,
        initialValue: widget.initialValue,
        hintStyle: AppTextStyles.formText,
        decoration: SpecialDecoration(
          hintText: widget.initialValue!,
          prefixStyle: const TextStyle(color: Colors.white),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        ).decoration,
      ),
    );
  }
}

class CurrencyDropDown2 extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final List<String> items;
  final Function(String?) onChanged;
  const CurrencyDropDown2({
    super.key,
    this.hintText,
    this.initialValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputBorderStyle(
        child: BaseFormFieldModal(
      hintText: hintText,
      initialValue: initialValue,
      readOnly: true,
      items: items,
      onChanged: onChanged,
      decoration: CustomInputDecoration(hintText: hintText!).decoration,
      hintStyle: AppTextStyles.formText,
    ));
  }
}
