import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/customer_transaction.dart';
import '../providers/customer_provider.dart';
import '../providers/transaction_provider.dart';

class TransactionCard extends StatelessWidget {
  final CustomerTransaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(transaction.id),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // create provider
          final customerProvider = Provider.of<CustomerProvider>(
            context,
            listen: false,
          );
          // delete transaction from database
          Provider.of<TransactionProvider>(
            context,
            listen: false,
          ).removeTransaction(transaction.id!, customerProvider);
          // show a snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Deleted: ${transaction.amount}')),
          );
        }
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          DateFormat('EEEE, MMM dd, yyyy').format(transaction.date),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          transaction.description != ''
              ? transaction.description!
              : 'No Description',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(transaction.type == 'youllGive' ? 'Debit' : 'Credit'),
            Text(
              transaction.amount.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color:
                    transaction.type == 'youllGive' ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
