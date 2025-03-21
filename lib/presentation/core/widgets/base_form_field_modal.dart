import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_guru/presentation/core/styles/text_styles/app_text_styles.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class BaseFormFieldModal extends StatefulWidget {
  final Function(String?)? onChanged;
  final String? initialValue;
  final InputDecoration? decoration;
  final String? Function(String?, BuildContext)? validator;
  final TextStyle? hintStyle;
  final List<String>? items;
  final String? hintText;
  final TextEditingController? controller;
  final bool enabled;
  final bool readOnly;
  final bool? disabled;

  const BaseFormFieldModal(
      {super.key,
      this.onChanged,
      this.initialValue,
      this.decoration,
      this.hintStyle,
      this.items,
      this.controller,
      this.hintText,
      this.enabled = true,
      this.readOnly = false,
      this.validator,
      this.disabled});

  @override
  State<BaseFormFieldModal> createState() => _BaseFormFieldModalState();
}

class _BaseFormFieldModalState extends State<BaseFormFieldModal> {
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
    Size size = MediaQuery.of(context).size;
    InputDecoration defaultDecoration = _buildDefaultDecoration(size, context);

    return TextFormField(
      readOnly: widget.readOnly,
      validator: widget.validator != null
          ? (value) => widget.validator!(value, context)
          : null,
      decoration: defaultDecoration,
      controller: _controller,
      onChanged: widget.onChanged,
      style: GoogleFonts.montserrat(
        color: Colors.white,
      ),
    );
  }

  InputDecoration _buildDefaultDecoration(Size size, BuildContext context) {
    UnderlineInputBorder defaultBorder = UnderlineInputBorder(
        borderSide: BorderSide(
      color: widget.decoration != null
          ? Colors.transparent
          : const Color(0xFF494949),
    ));

    return InputDecoration(
      disabledBorder: defaultBorder,
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: defaultBorder,
      hintText: widget.hintText,
      hintStyle: AppTextStyles.specialFormText,
      errorBorder: defaultBorder,
      errorMaxLines: 5,
      focusedErrorBorder: defaultBorder,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.only(
        left: 16,
        right: 0,
        top: 20.0,
        bottom: 16.0,
      ),
      suffixIcon: GestureDetector(
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
        ),
        onTap: () => _showOptionDialog(context, widget.enabled),
      ),
    );
  }

  Future<dynamic>? _showOptionDialog(
    BuildContext ctx,
    bool enabled,
  ) {
    if (enabled) {
      return showDialog(
        context: ctx,
        builder: (context) {
          bool hasItems = (widget.items!.length > 1);
          return BaseModal(
            hasCloseAction: true,
            widthFactor: 1,
            heightFactor: .8,
            hasActions: false,
            showCloseIcon: true,
            modalColor: Colors.black,
            content: _buildItemList(context),
          );
        },
      );
    } else {
      return null;
    }
  }

  Widget _buildItemList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: GestureDetector(
            onTap: () {
              widget.onChanged?.call(widget.items![index]);
              _controller.text = widget.items![index];
              Navigator.pop(context);
            },
            child: TextBase(text: widget.items![index]),
          ),
        );
      },
    );
  }
}
