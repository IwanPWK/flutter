// lib/providers/pharmacy_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../database/pharmacy_database.dart';
import '../models/pharmacy_models.dart';

// Tambahkan provider untuk low stock items
final lowStockItemsProvider = AsyncNotifierProvider<LowStockNotifier, List<InventoryModel>>(() {
  return LowStockNotifier();
});

class LowStockNotifier extends AsyncNotifier<List<InventoryModel>> {
  @override
  Future<List<InventoryModel>> build() async {
    final database = ref.read(databaseProvider);
    final lowStockItems = await database.inventoryDao.getLowStockItems();
    
    return lowStockItems.map((item) {
      return InventoryModel.fromDrift(
        item.inventory,
        medicine: item.medicine != null 
            ? MedicineModel.fromDrift(
                item.medicine!,
                category: item.category != null ? CategoryModel.fromDrift(item.category!) : null,
              ) 
            : null,
        supplier: item.supplier != null ? SupplierModel.fromDrift(item.supplier!) : null,
      );
    }).toList();
  }

  Future<void> refresh() async {
    final database = ref.read(databaseProvider);
    final lowStockItems = await database.inventoryDao.getLowStockItems();
    
    state = AsyncValue.data(lowStockItems.map((item) {
      return InventoryModel.fromDrift(
        item.inventory,
        medicine: item.medicine != null 
            ? MedicineModel.fromDrift(
                item.medicine!,
                category: item.category != null ? CategoryModel.fromDrift(item.category!) : null,
              ) 
            : null,
        supplier: item.supplier != null ? SupplierModel.fromDrift(item.supplier!) : null,
      );
    }).toList());
  }
}
// Tambahkan ke lib/providers/pharmacy_providers.dart

// Supplier Providers using DAO
final supplierNotifierProvider = AsyncNotifierProvider<SupplierNotifier, List<SupplierModel>>(() {
  return SupplierNotifier();
});

class SupplierNotifier extends AsyncNotifier<List<SupplierModel>> {
  @override
  Future<List<SupplierModel>> build() async {
    final database = ref.read(databaseProvider);
    final suppliers = await database.supplierDao.getAllSuppliers();
    return suppliers.map((e) => SupplierModel.fromDrift(e)).toList();
  }

  Future<void> addSupplier({
    required String name,
    required String contact,
    required String address,
    required String email,
  }) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.supplierDao.insertSupplier(SuppliersCompanion(
        name: Value(name),
        contact: Value(contact),
        address: Value(address),
        email: Value(email),
      ));
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateSupplier(int id, {
    String? name,
    String? contact,
    String? address,
    String? email,
  }) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.supplierDao.updateSupplier(id, SuppliersCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        contact: contact != null ? Value(contact) : const Value.absent(),
        address: address != null ? Value(address) : const Value.absent(),
        email: email != null ? Value(email) : const Value.absent(),
      ));
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteSupplier(int id) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.supplierDao.deleteSupplier(id);
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> _refresh() async {
    final database = ref.read(databaseProvider);
    final suppliers = await database.supplierDao.getAllSuppliers();
    state = AsyncValue.data(suppliers.map((e) => SupplierModel.fromDrift(e)).toList());
  }
}

final databaseProvider = Provider<PharmacyDatabase>((ref) {
  return PharmacyDatabase();
});

// Category Providers using DAO
final categoryNotifierProvider = AsyncNotifierProvider<CategoryNotifier, List<CategoryModel>>(() {
  return CategoryNotifier();
});

class CategoryNotifier extends AsyncNotifier<List<CategoryModel>> {
  @override
  Future<List<CategoryModel>> build() async {
    final database = ref.read(databaseProvider);
    final categories = await database.categoryDao.getAllCategories();
    return categories.map((e) => CategoryModel.fromDrift(e)).toList();
  }

  Future<void> addCategory(String name, String description) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.categoryDao.insertCategory(CategoriesCompanion(
        name: Value(name),
        description: Value(description),
      ));
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateCategory(int id, String name, String description) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.categoryDao.updateCategory(id, CategoriesCompanion(
        name: Value(name),
        description: Value(description),
      ));
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteCategory(int id) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.categoryDao.deleteCategory(id);
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> _refresh() async {
    final database = ref.read(databaseProvider);
    final categories = await database.categoryDao.getAllCategories();
    state = AsyncValue.data(categories.map((e) => CategoryModel.fromDrift(e)).toList());
  }
}

// Medicine Providers using DAO
final medicineNotifierProvider = AsyncNotifierProvider<MedicineNotifier, List<MedicineModel>>(() {
  return MedicineNotifier();
});

class MedicineNotifier extends AsyncNotifier<List<MedicineModel>> {
  @override
  Future<List<MedicineModel>> build() async {
    final database = ref.read(databaseProvider);
    final medicinesWithCategory = await database.medicineDao.getAllMedicinesWithCategory();
    
    return medicinesWithCategory.map((item) {
      return MedicineModel.fromDrift(
        item.medicine,
        category: item.category != null ? CategoryModel.fromDrift(item.category!) : null,
      );
    }).toList();
  }

  Future<void> addMedicine({
    required String name,
    required String description,
    required int categoryId,
    required double price,
    required String unit,
    required DateTime expiredAt,
  }) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.medicineDao.insertMedicine(MedicinesCompanion(
        name: Value(name),
        description: Value(description),
        categoryId: Value(categoryId),
        price: Value(price),
        unit: Value(unit),
        expiredAt: Value(expiredAt),
      ));
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateMedicine(int id, {
    String? name,
    String? description,
    int? categoryId,
    double? price,
    String? unit,
    DateTime? expiredAt,
  }) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.medicineDao.updateMedicine(id, MedicinesCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        description: description != null ? Value(description) : const Value.absent(),
        categoryId: categoryId != null ? Value(categoryId) : const Value.absent(),
        price: price != null ? Value(price) : const Value.absent(),
        unit: unit != null ? Value(unit) : const Value.absent(),
        expiredAt: expiredAt != null ? Value(expiredAt) : const Value.absent(),
      ));
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteMedicine(int id) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.medicineDao.deleteMedicine(id);
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> _refresh() async {
    final database = ref.read(databaseProvider);
    final medicinesWithCategory = await database.medicineDao.getAllMedicinesWithCategory();
    
    state = AsyncValue.data(medicinesWithCategory.map((item) {
      return MedicineModel.fromDrift(
        item.medicine,
        category: item.category != null ? CategoryModel.fromDrift(item.category!) : null,
      );
    }).toList());
  }
}

// Inventory Providers using DAO
final inventoryNotifierProvider = AsyncNotifierProvider<InventoryNotifier, List<InventoryModel>>(() {
  return InventoryNotifier();
});

class InventoryNotifier extends AsyncNotifier<List<InventoryModel>> {
  @override
  Future<List<InventoryModel>> build() async {
    final database = ref.read(databaseProvider);
    final inventoriesWithRelations = await database.inventoryDao.getAllInventoriesWithRelations();
    
    return inventoriesWithRelations.map((item) {
      return InventoryModel.fromDrift(
        item.inventory,
        medicine: item.medicine != null 
            ? MedicineModel.fromDrift(
                item.medicine!,
                category: item.category != null ? CategoryModel.fromDrift(item.category!) : null,
              ) 
            : null,
        supplier: item.supplier != null ? SupplierModel.fromDrift(item.supplier!) : null,
      );
    }).toList();
  }

  Future<void> addInventory({
    required int medicineId,
    required int supplierId,
    required int quantity,
    required int minimumStock,
  }) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.inventoryDao.insertInventory(InventoriesCompanion(
        medicineId: Value(medicineId),
        supplierId: Value(supplierId),
        quantity: Value(quantity),
        minimumStock: Value(minimumStock),
        lastRestocked: Value(DateTime.now()),
      ));
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateInventoryStock(int id, int newQuantity) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.inventoryDao.updateInventory(id, InventoriesCompanion(
        quantity: Value(newQuantity),
        lastRestocked: Value(DateTime.now()),
      ));
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteInventory(int id) async {
    state = const AsyncValue.loading();
    try {
      final database = ref.read(databaseProvider);
      await database.inventoryDao.deleteInventory(id);
      await _refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> _refresh() async {
    final database = ref.read(databaseProvider);
    final inventoriesWithRelations = await database.inventoryDao.getAllInventoriesWithRelations();
    
    state = AsyncValue.data(inventoriesWithRelations.map((item) {
      return InventoryModel.fromDrift(
        item.inventory,
        medicine: item.medicine != null 
            ? MedicineModel.fromDrift(
                item.medicine!,
                category: item.category != null ? CategoryModel.fromDrift(item.category!) : null,
              ) 
            : null,
        supplier: item.supplier != null ? SupplierModel.fromDrift(item.supplier!) : null,
      );
    }).toList());
  }
}
