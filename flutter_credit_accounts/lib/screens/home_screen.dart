import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/customer_provider.dart';
import '../widgets/action_button.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/customer_card.dart';
import '../widgets/customer_form.dart';
import '../widgets/header.dart';
import '../widgets/summary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: Consumer<CustomerProvider>(
          builder: (context, customerProvider, child) {
            final customersList = customerProvider.customersList;
            final totals = customerProvider.calculateUserTotals();
            return Column(
              children: [
                // header
                Header(
                  leading: CircleAvatar(
                    backgroundColor: lightBlue,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  title: 'Source code',
                  subtitle: 'Balance: ${totals['netBalance'] ?? 0.00}',
                  trailing: CircleAvatar(
                    backgroundColor: lightBlue,
                    child: const Icon(Icons.assessment, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // summary
                Summary(
                  youllGet: totals['youllGet'] ?? 0.00,
                  youllGive: totals['youllGive'] ?? 0.00,
                  netBalance: null,
                ),
                const SizedBox(height: 20),
                // ========================
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // search
                        CustomSearchBar(
                          hintText: 'Search Customer',
                          onChanged: (value) {
                            // change the query to the value of searchbar
                            customerProvider.query = value;
                          },
                        ),
                        Expanded(
                          // if the customer list is empty, show a message 'no customers'
                          // else show the customer list
                          child:
                              customersList.isEmpty
                                  ? const Center(child: Text('No Customers'))
                                  : ListView.builder(
                                    itemCount: customersList.length,
                                    itemBuilder:
                                        (context, index) => CustomerCard(
                                          customer: customersList[index],
                                        ),
                                  ),
                        ),

                        // add customer button
                        ActionButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => const CustomerForm(),
                            );
                          },
                          title: 'Add Customer',
                        ),
                      ],
                    ),
                  ),
                ),

                // customer list
              ],
            );
          },
        ),
      ),
    );
  }
}
