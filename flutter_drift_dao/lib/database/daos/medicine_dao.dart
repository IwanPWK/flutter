// lib/database/daos/medicine_dao.dart
import 'package:drift/drift.dart';
import '../pharmacy_database.dart';

part 'medicine_dao.g.dart';

@DriftAccessor(tables: [Medicines, Categories])
class MedicineDao extends DatabaseAccessor<PharmacyDatabase> with _$MedicineDaoMixin {
  MedicineDao(PharmacyDatabase db) : super(db);

  // READ - Get all medicines
  Future<List<Medicine>> getAllMedicines() {
    return select(medicines).get();
  }

  // READ - Get medicines with category info
  Future<List<MedicineWithCategory>> getAllMedicinesWithCategory() {
    final query = select(medicines).join([
      leftOuterJoin(categories, categories.id.equalsExp(medicines.categoryId))
    ]);
    
    return query.map((row) {
      final medicine = row.readTable(medicines);
      final category = row.readTableOrNull(categories);
      return MedicineWithCategory(medicine: medicine, category: category);
    }).get();
  }

  // READ - Get medicine by ID with category
  Future<MedicineWithCategory?> getMedicineWithCategoryById(int id) {
    final query = select(medicines).join([
      leftOuterJoin(categories, categories.id.equalsExp(medicines.categoryId))
    ])..where(medicines.id.equals(id));
    
    return query.map((row) {
      final medicine = row.readTable(medicines);
      final category = row.readTableOrNull(categories);
      return MedicineWithCategory(medicine: medicine, category: category);
    }).getSingleOrNull();
  }

  // CREATE - Insert new medicine
  Future<int> insertMedicine(MedicinesCompanion medicine) {
    return into(medicines).insert(medicine);
  }

  // UPDATE - Update medicine
  Future<int> updateMedicine(int id, MedicinesCompanion medicine) {
    return (update(medicines)..where((m) => m.id.equals(id))).write(medicine);
  }

  // DELETE - Delete medicine
  Future<int> deleteMedicine(int id) {
    return (delete(medicines)..where((m) => m.id.equals(id))).go();
  }
}

// Helper class untuk join result
class MedicineWithCategory {
  final Medicine medicine;
  final Category? category;

  MedicineWithCategory({required this.medicine, this.category});
}
