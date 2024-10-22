import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String transactionType;
  final String amount;

  const TransactionItem({
    super.key,
    required this.title,
    required this.transactionType,
    required this.amount,
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
          Icon(
            title == 'OutgoingPayment'
                ? Icons.arrow_circle_up
                : Icons.arrow_circle_down,
            color: Colors.white,
            size: size.width * 0.07,
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: TextBase(
              text: title,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextBase(
            text: toCurrencyString(amount, leadingSymbol: '\$'),
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
