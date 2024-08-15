import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class AuthLoginDivider extends StatelessWidget {
  const AuthLoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 67,
      child: Divider(
        color: AppColorSchema.of(context).lineColor,
        thickness: 4,
      ),
    );
  }
}
