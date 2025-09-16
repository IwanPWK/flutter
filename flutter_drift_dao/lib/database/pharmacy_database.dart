// lib/database/pharmacy_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'daos/category_dao.dart';
import 'daos/supplier_dao.dart';
import 'daos/medicine_dao.dart';
import 'daos/inventory_dao.dart';

part 'pharmacy_database.g.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get contact => text().withLength(min: 1, max: 50)();
  TextColumn get address => text()();
  TextColumn get email => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Medicines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  RealColumn get price => real()();
  TextColumn get unit => text().withLength(min: 1, max: 20)();
  DateTimeColumn get expiredAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Inventories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get medicineId => integer().references(Medicines, #id)();
  IntColumn get supplierId => integer().references(Suppliers, #id)();
  IntColumn get quantity => integer()();
  IntColumn get minimumStock => integer()();
  DateTimeColumn get lastRestocked => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [Categories, Suppliers, Medicines, Inventories],
  daos: [CategoryDao, SupplierDao, MedicineDao, InventoryDao],
)
class PharmacyDatabase extends _$PharmacyDatabase {
  PharmacyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'pharmacy.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
