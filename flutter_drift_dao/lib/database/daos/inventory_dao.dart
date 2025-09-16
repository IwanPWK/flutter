// lib/database/daos/inventory_dao.dart
import 'package:drift/drift.dart';
import '../pharmacy_database.dart';

part 'inventory_dao.g.dart';

@DriftAccessor(tables: [Inventories, Medicines, Suppliers, Categories])
class InventoryDao extends DatabaseAccessor<PharmacyDatabase> with _$InventoryDaoMixin {
  InventoryDao(PharmacyDatabase db) : super(db);

  // READ - Get all inventories
  Future<List<Inventory>> getAllInventories() {
    return select(inventories).get();
  }

  // READ - Get inventories with full relations
  Future<List<InventoryWithRelations>> getAllInventoriesWithRelations() {
    final query = select(inventories).join([
      leftOuterJoin(medicines, medicines.id.equalsExp(inventories.medicineId)),
      leftOuterJoin(suppliers, suppliers.id.equalsExp(inventories.supplierId)),
      leftOuterJoin(categories, categories.id.equalsExp(medicines.categoryId))
    ]);
    
    return query.map((row) {
      final inventory = row.readTable(inventories);
      final medicine = row.readTableOrNull(medicines);
      final supplier = row.readTableOrNull(suppliers);
      final category = row.readTableOrNull(categories);
      
      return InventoryWithRelations(
        inventory: inventory,
        medicine: medicine,
        supplier: supplier,
        category: category,
      );
    }).get();
  }

  // READ - Get inventory by ID
  Future<Inventory?> getInventoryById(int id) {
    return (select(inventories)..where((i) => i.id.equals(id))).getSingleOrNull();
  }

  // CREATE - Insert new inventory
  Future<int> insertInventory(InventoriesCompanion inventory) {
    return into(inventories).insert(inventory);
  }

  // UPDATE - Update inventory
  Future<int> updateInventory(int id, InventoriesCompanion inventory) {
    return (update(inventories)..where((i) => i.id.equals(id))).write(inventory);
  }

  // DELETE - Delete inventory
  Future<int> deleteInventory(int id) {
    return (delete(inventories)..where((i) => i.id.equals(id))).go();
  }

  // SPECIAL - Get low stock items
  Future<List<InventoryWithRelations>> getLowStockItems() {
    final query = select(inventories).join([
      leftOuterJoin(medicines, medicines.id.equalsExp(inventories.medicineId)),
      leftOuterJoin(suppliers, suppliers.id.equalsExp(inventories.supplierId)),
      leftOuterJoin(categories, categories.id.equalsExp(medicines.categoryId))
    ])..where(inventories.quantity.isSmallerOrEqual(inventories.minimumStock));
    
    return query.map((row) {
      final inventory = row.readTable(inventories);
      final medicine = row.readTableOrNull(medicines);
      final supplier = row.readTableOrNull(suppliers);
      final category = row.readTableOrNull(categories);
      
      return InventoryWithRelations(
        inventory: inventory,
        medicine: medicine,
        supplier: supplier,
        category: category,
      );
    }).get();
  }
}

// Helper class untuk join result
class InventoryWithRelations {
  final Inventory inventory;
  final Medicine? medicine;
  final Supplier? supplier;
  final Category? category;

  InventoryWithRelations({
    required this.inventory,
    this.medicine,
    this.supplier,
    this.category,
  });
}
