import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';

class ProgressBar extends StatelessWidget {
  final int currentStep;

  const ProgressBar({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _showAsset(currentStep), // Call the method to show the correct asset
      ],
    );
  }

  Widget _showAsset(int currentStep) {
    // Depending on the current step, return the correct asset
    switch (currentStep) {
      case 1:
        return SvgPicture.asset(
          Assets.stepProgress,
        );
      case 2:
        return SvgPicture.asset(
          Assets.stepProgress2,
        );
      case 3:
        return SvgPicture.asset(
          Assets.stepProgress3,
        );
      default:
        return SvgPicture.asset(
          Assets.stepProgress4,
        );
    }
  }
}
