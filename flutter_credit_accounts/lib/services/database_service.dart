import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/customer.dart';
import '../models/customer_transaction.dart';

class DatabaseService {
  // make it a singleton class
  // private constructor
  DatabaseService._init();
  static final DatabaseService instance = DatabaseService._init();

  // database
  Database? _database;

  Future<Database> get database async {
    // if already exists, return that database
    if (_database != null) return _database!;

    // otherwise, create a new database
    _database = await _initDb();
    return _database!;
  }

  // initDb method
  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath(); // usually data/data/ ...
    final path = join(dbPath, 'credit_account.db');

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  // _createDb Method -> creating tables
  Future<void> _createDb(Database db, int version) async {
    await db.transaction((txn) async {
      // customer table
      await txn.execute('''CREATE TABLE customers(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      created TEXT,
      youllGet REAL,
      youllGive REAL
      )''');

      // transaction table
      await txn.execute('''CREATE TABLE transactions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      customerId INTEGER,
      amount REAL,
      date TEXT,
      type TEXT,
      description TEXT,
      FOREIGN KEY(customerId) REFERENCES customers(id) ON DELETE CASCADE)''');
    });
  }

  // CRUD METHODS //

  // Customer Methods //
  Future<List<Customer>> getCustomers() async {
    // get the database
    final db = await database;
    // get the data and save it ini a variable
    final maps = await db.query('customers');
    // generate the list of customer and return it
    return List.generate(maps.length, (index) => Customer.fromMap(maps[index]));
  }

  // add a customer -> adds a customer in database and generates id
  Future<int> addCustomer(Customer customer) async {
    final db = await database;
    final generatedId = await db.insert(
      'customers',
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // this generatedId will be used to create and save a new customer
    // in the customer_provider list.
    return generatedId;
  }

  // delete a customer
  Future<int> deleteCustomer(int customerId) async {
    final db = await database;
    return await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [customerId],
    );
  }

  // update a customer
  Future<int> updateCustomer(Customer customer) async {
    final db = await database;
    return await db.update(
      'customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  // transaction methods //
  // this method will be used to fetch the list of transactions of a specific
  // customer, this will be called from the transation_provider
  Future<List<CustomerTransaction>> getCustomerTransactions(
    int customerId,
  ) async {
    final db = await database;
    final maps = await db.query(
      'transactions',
      where: 'customerId = ?',
      whereArgs: [customerId],
    );
    // generate the list and return
    return List.generate(
      maps.length,
      (index) => CustomerTransaction.fromMap(maps[index]),
    );
  }

  // add a transaction and return the generated id
  Future<int> addTransaction(CustomerTransaction transaction) async {
    final db = await database;
    final generatedId = await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return generatedId;
  }

  // remove the transaction
  Future<int> removeTransaction(int transactionId) async {
    final db = await database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [transactionId],
    );
  }

  // update a transaction
  Future<int> updateTransaction(CustomerTransaction transaction) async {
    final db = await database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
