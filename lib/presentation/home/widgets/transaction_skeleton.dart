import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class TransactionSkeleton extends StatelessWidget {
  const TransactionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Skeletonizer(
      enabled: true,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        padding: EdgeInsets.all(size.width * 0.03),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColorSchema.of(context).tertiaryText,
          ),
          borderRadius: BorderRadius.circular(size.width * 0.03),
        ),
        child: Row(
          children: [
            Icon(Icons.payment, size: size.width * 0.07),
            SizedBox(width: size.width * 0.03),
            Expanded(
              child: Container(
                width: double.infinity,
                height: size.height * 0.02,
                color: AppColorSchema.of(context).tertiaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
