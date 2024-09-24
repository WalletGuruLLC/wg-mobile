import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        color: AppColorSchema.of(context).tertiaryText,
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBase(
            text: "Balance",
            fontSize: size.width * 0.04,
          ),
          SizedBox(height: size.height * 0.01),
          TextBase(
            text: "\$10,567.30",
            fontSize: size.width * 0.1,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBase(
                text: "Reserved Funds:\n\$1,500.13",
                fontSize: size.width * 0.035,
              ),
              TextBase(
                text: "Available Funds:\n\$9,067.17",
                fontSize: size.width * 0.035,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
