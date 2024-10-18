import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/dynamic_container.dart';
import 'package:wallet_guru/domain/transactions/models/transactions_model.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class TransactionDetailsPopup extends StatelessWidget {
  final TransactionsModel transaction;

  const TransactionDetailsPopup({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: DynamicContainer(
        minWidth: 300,
        maxWidth: 350,
        padding: const EdgeInsets.all(20),
        colorContainer: Colors.white,
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
        bottomLeft: const Radius.circular(20),
        bottomRight: const Radius.circular(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBase(
                text: l10n.transactionsDetails,
                fontSize: size.width * 0.04,
                color: AppColorSchema.of(context).secondaryText,
              ),
              IconButton(
                icon: Icon(Icons.close,
                    color: AppColorSchema.of(context).secondaryText),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
              l10n.transactionsDetailsPayedTo, transaction.receiverUrl, size),
          _buildDetailRow(l10n.transactionsDetailsWalletAddress,
              transaction.senderUrl, size),
          _buildDetailRow(l10n.transactionsDetailsDate,
              DateFormat('MM/dd/yyyy').format(transaction.createdAt), size),
          _buildDetailRow(l10n.transactionsDetailsTime,
              DateFormat('hh:mm a').format(transaction.createdAt), size),
          _buildDetailRow(l10n.transactionsDetailsAmount,
              '\$${_getAmount(transaction)}', size),
          _buildDetailRow(
              l10n.transactionsDetailsStatus, transaction.state, size),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TextBase(
              text: label,
              fontSize: size.width * 0.032,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextBase(
              text: value,
              fontSize: size.width * 0.032,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  String _getAmount(TransactionsModel transaction) {
    final amount = transaction.type == 'IncomingPayment'
        ? transaction.incomingAmount?.value
        : transaction.receiveAmount?.value;
    return (amount ?? 0).toStringAsFixed(2);
  }
}
