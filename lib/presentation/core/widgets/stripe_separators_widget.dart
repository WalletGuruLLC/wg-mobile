import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class StripeSeparatorsWidget extends StatelessWidget {
  const StripeSeparatorsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(
          color: AppColorSchema.of(context).primaryText.withOpacity(0.5)),
    );
  }
}
