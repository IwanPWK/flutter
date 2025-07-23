import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/database_service.dart';

// Will handle the customers list, CRUD to db.
class CustomerProvider with ChangeNotifier {
  // dataase instance
  final DatabaseService _db = DatabaseService.instance;
  // create a customer list, this will be displayed on the app screen
  List<Customer> _customersList = [];
  List<Customer> get customersList => _customersList;

  // load the customers when this provider is initiated
  CustomerProvider() {
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    _customersList = await _db.getCustomers();
    notifyListeners();
  }

  // methods

  // add
  Future<void> addCustomer(Customer customer) async {
    // here first it will be added to the database
    int id = await _db.addCustomer(customer);
    // then the received id will be used to create a new customer object
    final Customer newCustomer = customer.copyWith(id: id);
    // that object will be added to the _customersList
    _customersList.add(newCustomer);
    notifyListeners();
  }

  Future<void> updateCustomer(Customer updatedCustomer) async {
    await _db.updateCustomer(updatedCustomer);
    // find the customer in the list
    int index = _customersList.indexWhere(
      (customer) => customer.id == updatedCustomer.id,
    );
    if (index != -1) {
      // update the customer
      _customersList[index] = updatedCustomer;
      notifyListeners();
    }
  }

  Future<void> deleteCustomer(int customerId) async {
    await _db.deleteCustomer(customerId);
    _customersList.removeWhere((customer) => customer.id == customerId);
    notifyListeners();
  }

  // helper methods

  Customer? findCustomerById(int customerId) {
    try {
      return _customersList.firstWhere((customer) => customer.id == customerId);
    } catch (e) {
      return null;
    }
  }

  // calculate totals
  Map<String, double> calculateUserTotals() {
    double youllGet = 0;
    double youllGive = 0;
    for (var customer in _customersList) {
      youllGet += customer.youllGet;
      youllGive += customer.youllGive;
    }
    return {
      'youllGet': youllGet,
      'youllGive': youllGive,
      'netBalance': youllGet - youllGive,
      // youllget -> user gave them money, youllgive -> user got money from the customer.
      // so if the user gave 1000 (user'll get) and user got 500 from the customer,
      // then the net Balance is 1000-500 = 500.
    };
  }

  void updateBalance(int customerId, double amount, bool isYoullGet) {
    // find the customer
    final customer = findCustomerById(customerId);

    if (customer != null) {
      // since our youllget and youllgive fields of the customer is final we
      // can't directly set it to a new value, so we define 2 new variables and set
      // it's value to the old customer's data.
      double youllGet = customer.youllGet;
      double youllGive = customer.youllGive;
      // check the type of transaction

      if (isYoullGet) {
        youllGet += amount;
      } else {
        youllGive += amount;
      }

      // create a new customer variable from this updated balances.
      final newCustomer = Customer(
        id: customerId,
        name: customer.name,
        created: customer.created,
        youllGet: youllGet,
        youllGive: youllGive,
      );

      // update in the list
      updateCustomer(newCustomer);
    }
  }
}
