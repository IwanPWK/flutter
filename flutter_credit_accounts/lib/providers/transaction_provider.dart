// will handle the transaction list related to a specific customer, and handle CRUD to db

import 'package:flutter/material.dart';

import '../models/customer_transaction.dart';
import '../services/database_service.dart';
import 'customer_provider.dart';

class TransactionProvider extends ChangeNotifier {
  // database instance
  final DatabaseService _db = DatabaseService.instance;
  String _query = '';
  List<CustomerTransaction> _transactionsList = [];
  // search by amount and description
  List<CustomerTransaction> get transactionsList =>
      _query == ''
          ? _transactionsList
          : _transactionsList
              .where(
                (tx) =>
                    tx.description!.toLowerCase().contains(_query) ||
                    tx.amount.toString().contains(_query),
              )
              .toList();

  set query(String value) {
    _query = value;
    notifyListeners();
  }

  Future<void> loadTransactions(int customerId) async {
    _transactionsList = await _db.getCustomerTransactions(customerId);
    notifyListeners();
  }

  // add
  Future<void> addTransaction(
    CustomerTransaction transaction,
    CustomerProvider customerProvider,
  ) async {
    // we will add it in db first then will be added to _transactions
    int id = await _db.addTransaction(transaction);
    final newTransaction = transaction.copyWith(id: id);
    _transactionsList.add(newTransaction);
    // we need to update the customer after the transaction is added
    // call the update method
    customerProvider.updateBalance(
      newTransaction.customerId,
      newTransaction.amount,
      newTransaction.type ==
          'youllGet', // if it's true then 'true' else 'false'
    );
    notifyListeners();
  }

  // remove
  Future<void> removeTransaction(
    int transactionId,
    CustomerProvider customerProvider,
  ) async {
    // first find the transaction
    final transaction = findTransactionById(transactionId);
    // remove from the db and list
    if (transaction != null) {
      await _db.removeTransaction(transactionId);
      _transactionsList.removeWhere(
        (transaction) => transaction.id == transactionId,
      );
      // update the balance of customer
      customerProvider.updateBalance(
        transaction.customerId,
        -transaction.amount, // subtract the amount by adding '-'
        transaction.type == 'youllGet', // if it's true then 'true' else 'false'
      );
      notifyListeners();
    }
  }

  // helper methods
  CustomerTransaction? findTransactionById(int transactionId) {
    try {
      return _transactionsList.firstWhere(
        (transaction) => transaction.id == transactionId,
      );
    } catch (e) {
      return null;
    }
  }
}
