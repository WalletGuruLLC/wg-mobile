import 'package:flutter/material.dart';

class ActivatorFieldWidget extends StatelessWidget {
  final void Function()? onTap;
  const ActivatorFieldWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
