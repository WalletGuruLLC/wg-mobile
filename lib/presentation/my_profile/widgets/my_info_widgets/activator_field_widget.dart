import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';

class ActivatorFieldWidget extends StatelessWidget {
  final void Function()? onTap;
  final bool isIconPencil;
  const ActivatorFieldWidget({
    super.key,
    this.onTap,
    this.isIconPencil = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isIconPencil
          ? Image.asset(Assets.editInfoIcon, width: 20, height: 20)
          : const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 1,
            ),
    );
  }
}
