import 'package:flutter/material.dart';
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
          Text(
            "Balance",
            style: TextStyle(color: Colors.white, fontSize: size.width * 0.04),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            "\$10,567.30",
            style: TextStyle(
              fontSize: size.width * 0.1,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reserved Funds:\n\$1,500.13",
                style: TextStyle(
                    color: Colors.white70, fontSize: size.width * 0.035),
              ),
              Text(
                "Available Funds:\n\$9,067.17",
                style: TextStyle(
                    color: Colors.white70, fontSize: size.width * 0.035),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
