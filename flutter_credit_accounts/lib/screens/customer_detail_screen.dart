import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/customer.dart';
import '../providers/customer_provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/action_button.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/header.dart';
import '../widgets/summary.dart';
import '../widgets/transaction_card.dart';
import '../widgets/transaction_form.dart';

class CustomerDetailScreen extends StatefulWidget {
  final Customer customer; // passed from the customer card.
  const CustomerDetailScreen({super.key, required this.customer});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  void initState() {
    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).loadTransactions(widget.customer.id!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // calculate the screen area
    final totalSize = MediaQuery.sizeOf(context);
    // substract the height of top (status) bar
    final topBar = MediaQuery.paddingOf(context).top;
    final workHeight = totalSize.height - topBar;
    return Scaffold(
      body: Container(
        // add some margin
        margin: EdgeInsets.only(top: topBar),
        width: totalSize.width,
        height: workHeight,
        // we need both providers here because this screen display bot data
        child: Consumer2<CustomerProvider, TransactionProvider>(
          builder: (context, customerProvider, transactionProvider, child) {
            // find the customer with id
            final currentCustomer = customerProvider.findCustomerById(
              widget.customer.id!,
            );
            final transactions = transactionProvider.transactionsList;
            return Column(
              children: [
                // header
                Header(
                  // back button
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: lightBlue,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                  title: currentCustomer!.name,
                  subtitle: DateFormat(
                    'MMM dd, yyyy',
                  ).format(currentCustomer.created),
                  trailing: CircleAvatar(
                    backgroundColor: lightBlue,
                    child: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // summary
                Summary(
                  youllGet: currentCustomer.youllGet,
                  youllGive: currentCustomer.youllGive,
                  netBalance:
                      (currentCustomer.youllGet - currentCustomer.youllGive)
                          .abs(),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // search
                        CustomSearchBar(
                          hintText: 'Search Transactions',
                          onChanged: (value) {
                            transactionProvider.query = value;
                          },
                        ),

                        // tramsaction list
                        Expanded(
                          child:
                              transactions.isEmpty
                                  ? Center(
                                    child: Text('No Transactions Found.'),
                                  )
                                  : ListView.builder(
                                    itemBuilder: (context, index) {
                                      final transaction = transactions[index];
                                      return TransactionCard(
                                        transaction: transaction,
                                      );
                                    },
                                    itemCount: transactions.length,
                                  ),
                        ),

                        // add transaction
                        ActionButton(
                          title: 'Add Transaction',
                          onPressed: () {
                            // navigate to form
                            showModalBottomSheet(
                              scrollControlDisabledMaxHeightRatio: 0.85,
                              context: context,
                              builder:
                                  (context) => TransactionForm(
                                    customerId: widget.customer.id!,
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
