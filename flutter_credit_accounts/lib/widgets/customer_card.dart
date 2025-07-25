import 'package:flutter/material.dart';

import 'package:flutter_credit_accounts/models/customer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/customer_provider.dart';
import '../screens/customer_detail_screen.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    // returning a dismissible widget so the user can swipe and delete
    final provider = Provider.of<CustomerProvider>(context, listen: false);
    double balance = (customer.youllGet - customer.youllGive);
    return Dismissible(
      key: ValueKey(customer.id),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // edit
        } else if (direction == DismissDirection.endToStart) {
          // this is right to left swipe
          provider.deleteCustomer(customer.id!);
          // after deletion show a message to the user
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${customer.name} deleted.')));
        }
      },
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerDetailScreen(customer: customer),
            ),
          );
        },
        contentPadding: EdgeInsets.zero,
        // first letter of the customer name
        leading: CircleAvatar(
          backgroundColor: lightBlue,
          child: Text(customer.name[0], style: TextStyle(color: Colors.white)),
        ),
        title: Text(
          customer.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Added: ${DateFormat('MMM dd, yyyy').format(customer.created)}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // youllget, youllgive
            Text(
              balance > 0 ? 'Youll Get' : 'Youll Give',
              style: TextStyle(fontSize: 12),
            ),
            // amount
            Text(
              balance.abs().toStringAsFixed(2),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: balance > 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
