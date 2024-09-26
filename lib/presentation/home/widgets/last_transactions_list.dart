import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/home/widgets/transaction_item.dart';

class LastTransactionsList extends StatelessWidget {
  const LastTransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBase(
          text: "Last transactions",
          fontSize: size.width * 0.04,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: size.height * 0.02),
        TransactionItem(
          title: "Coffee Shop",
          amount: "-\$3.68",
          icon: Icons.local_cafe,
        ),
        TransactionItem(
          title: "Streaming PPV",
          amount: "-\$3.50",
          icon: Icons.tv,
        ),
        TransactionItem(
          title: "Daily Phone Usage",
          amount: "-\$0.20",
          icon: Icons.phone,
        ),
        TransactionItem(
          title: "Incoming Funds",
          amount: "+\$53.22",
          icon: Icons.arrow_downward,
        ),
        SizedBox(height: size.height * 0.01),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: TextBase(
              text: "See more",
              color: Colors.blue,
              fontSize: size.width * 0.035,
            ),
          ),
        ),
      ],
    );
  }
}
