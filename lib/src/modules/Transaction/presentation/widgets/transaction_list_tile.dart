import 'package:flutter/material.dart';
import 'package:remitance/src/modules/Transaction/domain/Entity/transaction_entity.dart';
import 'package:remitance/src/modules/Transaction/presentation/controller/home_controller.dart';
import 'package:remitance/src/utils/ext/color_extension.dart';
import 'package:remitance/src/utils/ext/text_style_extension.dart';
import 'package:remitance/src/utils/helper/date_formater.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.transaction,
    required this.controller,
  });

  final TransactionEntity transaction;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final isIncoming = transaction.type == 'topup' ||
        transaction.receiverUserEmail == controller.user.email;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isIncoming
                ? context.primary.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getTransactionIcon(),
            color: isIncoming ? context.primary : Colors.red,
            size: 24,
          ),
        ),
        title: _buildTitle(context),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.description,
                style: context.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                formatUserDate(transaction.date.toLocal()),
                style: context.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.color
                      ?.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              isIncoming
                  ? '+${transaction.amount.toStringAsFixed(2)}'
                  : '-${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: isIncoming ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isIncoming
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isIncoming ? 'Credit' : 'Debit',
                style: TextStyle(
                  color: isIncoming ? Colors.green : Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTransactionIcon() {
    if (transaction.type == 'send' &&
        transaction.receiverUserEmail == controller.user.email) {
      return Icons.call_received;
    } else if (transaction.type == 'send' &&
        transaction.currentUserEmail == controller.user.email) {
      return Icons.call_made;
    }
    return Icons.account_balance_wallet;
  }

  Widget _buildTitle(BuildContext context) {
    if (transaction.type == 'send' &&
        transaction.receiverUserEmail == controller.user.email) {
      return _buildTitleRow(
          'Received from', transaction.receiverUserEmail ?? "Unknown", context);
    } else if (transaction.type == 'send' &&
        transaction.currentUserEmail == controller.user.email) {
      return _buildTitleRow(
          'Sent to', transaction.receiverUserEmail ?? "Unknown", context);
    }
    return Text(
      'Top Up ${transaction.receiverUserEmail ?? "Unknown"}',
      style: context.headlineMedium,
    );
  }

  Widget _buildTitleRow(String prefix, String email, BuildContext context) {
    return Row(
      children: [
        Text(
          '$prefix: ',
          style: context.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            email,
            style: context.bodyMedium?.copyWith(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
