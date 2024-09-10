import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Size size;

  const TransactionItem({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
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
            child: Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontSize: size.width * 0.04),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: amount.startsWith('-') ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.045,
            ),
          ),
        ],
      ),
    );
  }
}
