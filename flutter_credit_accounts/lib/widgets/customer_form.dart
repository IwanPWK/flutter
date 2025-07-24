import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/customer.dart';
import '../providers/customer_provider.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _nameController = TextEditingController(); // customer name
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
    _nameController.dispose();
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
          // customer name
          TextField(
            // assign the controller
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Customer Name',
              border: OutlineInputBorder(),
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 20),
          // created on
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
                        : _selectedDate.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // add button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(14),
            ),

            onPressed: () async {
              if (_nameController.text.trim() != '' && _selectedDate != null) {
                // print('Customer name: ${_nameController.text}');
                // create a customer
                final customer = Customer(
                  name: _nameController.text,
                  created: _selectedDate!,
                  youllGet: 0.0,
                  youllGive: 0.0,
                );
                final provider = Provider.of<CustomerProvider>(
                  context,
                  listen: false,
                );
                // insert in database
                await provider.addCustomer(customer);
                // close the bottom sheet
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Add Customer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
