import 'package:flutter/material.dart';

import 'package:flutter_credit_accounts/models/customer.dart';
import 'package:flutter_credit_accounts/widgets/customer_form.dart';
import 'package:provider/provider.dart';

import '../providers/customer_provider.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    // returning a dismissible widget so the user can swipe and delete
    final provider = Provider.of<CustomerProvider>(context, listen: false);
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
          // navigate to account_detail_screen
        },
        contentPadding: EdgeInsets.zero,
        // first letter of the customer name
        leading: CircleAvatar(child: Text(customer.name[0])),
        title: Text(customer.name),
        subtitle: Text(customer.created.toString()),
        // trailing: Text('${customer.youllGet} - ${customer.youllGive}'),
      ),
    );
  }
}
