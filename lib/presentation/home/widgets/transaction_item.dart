import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;

  const TransactionItem({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
          Icon(icon, color: Colors.white, size: size.width * 0.07),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: TextBase(
              text: title,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextBase(
            text: amount,
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
