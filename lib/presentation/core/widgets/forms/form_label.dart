import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class FormLabel extends StatelessWidget {
  final String label;

  const FormLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextBase(
      text: label,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }
}
