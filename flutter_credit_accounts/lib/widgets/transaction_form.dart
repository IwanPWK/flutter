import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/customer_transaction.dart';
import '../providers/customer_provider.dart';
import '../providers/transaction_provider.dart';
import 'action_button.dart';

class TransactionForm extends StatefulWidget {
  final int customerId; // which customer this transaction belongs to
  const TransactionForm({super.key, required this.customerId});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'youllGet';
  DateTime? _selectedDate;

  // datePicker
  _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      currentDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // transaction type
          DropdownButtonFormField<String>(
            items: [
              DropdownMenuItem(
                value: '',
                child: Text('Select Transaction Type'),
              ),
              DropdownMenuItem(value: 'youllGive', child: Text('GOT')),
              DropdownMenuItem(value: 'youllGet', child: Text('GAVE')),
            ],
            value: _selectedType,
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          // transaction amount
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Transaction Amount',
            ),
          ),
          const SizedBox(height: 20),
          // transaction description
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Description (optional)',
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _showDatePicker(),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87),

                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  // date Selector
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 16),
                  Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : DateFormat('MMM dd, yyyy').format(_selectedDate!),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),

          // action button
          ActionButton(
            title: 'Add Transaction',
            onPressed: () {
              if (_selectedType != '' &&
                  _amountController.text != '' &&
                  _selectedDate != null) {
                print(
                  'cek value $_selectedType ${_amountController.text} $_selectedDate',
                );
                // access the transaction provider
                final provider = Provider.of<TransactionProvider>(
                  context,
                  listen: false,
                );
                final customerProvider = Provider.of<CustomerProvider>(
                  context,
                  listen: false,
                );
                // create a transaction object.
                final tx = CustomerTransaction(
                  customerId: widget.customerId,
                  amount: double.parse(_amountController.text),
                  date: _selectedDate!,
                  type: _selectedType,
                  description: _descriptionController.text,
                );
                // add the transaction
                provider.addTransaction(tx, customerProvider);

                // navigate out of the form
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
