// lib/database/daos/supplier_dao.dart
import 'package:drift/drift.dart';
import '../pharmacy_database.dart';

part 'supplier_dao.g.dart';

@DriftAccessor(tables: [Suppliers])
class SupplierDao extends DatabaseAccessor<PharmacyDatabase> with _$SupplierDaoMixin {
  SupplierDao(PharmacyDatabase db) : super(db);

  // READ - Get all suppliers
  Future<List<Supplier>> getAllSuppliers() {
    return select(suppliers).get();
  }

  // READ - Get supplier by ID
  Future<Supplier?> getSupplierById(int id) {
    return (select(suppliers)..where((s) => s.id.equals(id))).getSingleOrNull();
  }

  // CREATE - Insert new supplier
  Future<int> insertSupplier(SuppliersCompanion supplier) {
    return into(suppliers).insert(supplier);
  }

  // UPDATE - Update supplier
  Future<int> updateSupplier(int id, SuppliersCompanion supplier) {
    return (update(suppliers)..where((s) => s.id.equals(id))).write(supplier);
  }

  // DELETE - Delete supplier
  Future<int> deleteSupplier(int id) {
    return (delete(suppliers)..where((s) => s.id.equals(id))).go();
  }
}
