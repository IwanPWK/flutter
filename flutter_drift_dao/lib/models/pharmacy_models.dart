// lib/models/pharmacy_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../database/pharmacy_database.dart';

part 'pharmacy_models.freezed.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required int id,
    required String name,
    required String description,
    required DateTime createdAt,
  }) = _CategoryModel;

  factory CategoryModel.fromDrift(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      description: category.description,
      createdAt: category.createdAt,
    );
  }
}

@freezed
abstract class SupplierModel with _$SupplierModel {
  const factory SupplierModel({
    required int id,
    required String name,
    required String contact,
    required String address,
    required String email,
    required DateTime createdAt,
  }) = _SupplierModel;

  factory SupplierModel.fromDrift(Supplier supplier) {
    return SupplierModel(
      id: supplier.id,
      name: supplier.name,
      contact: supplier.contact,
      address: supplier.address,
      email: supplier.email,
      createdAt: supplier.createdAt,
    );
  }
}

@freezed
abstract class MedicineModel with _$MedicineModel {
  const factory MedicineModel({
    required int id,
    required String name,
    required String description,
    required int categoryId,
    required double price,
    required String unit,
    required DateTime expiredAt,
    required DateTime createdAt,
    CategoryModel? category,
  }) = _MedicineModel;

  factory MedicineModel.fromDrift(Medicine medicine, {CategoryModel? category}) {
    return MedicineModel(
      id: medicine.id,
      name: medicine.name,
      description: medicine.description,
      categoryId: medicine.categoryId,
      price: medicine.price,
      unit: medicine.unit,
      expiredAt: medicine.expiredAt,
      createdAt: medicine.createdAt,
      category: category,
    );
  }
}

@freezed
abstract class InventoryModel with _$InventoryModel {
  const factory InventoryModel({
    required int id,
    required int medicineId,
    required int supplierId,
    required int quantity,
    required int minimumStock,
    required DateTime lastRestocked,
    required DateTime createdAt,
    MedicineModel? medicine,
    SupplierModel? supplier,
  }) = _InventoryModel;

  factory InventoryModel.fromDrift(
    Inventory inventory, {
    MedicineModel? medicine,
    SupplierModel? supplier,
  }) {
    return InventoryModel(
      id: inventory.id,
      medicineId: inventory.medicineId,
      supplierId: inventory.supplierId,
      quantity: inventory.quantity,
      minimumStock: inventory.minimumStock,
      lastRestocked: inventory.lastRestocked,
      createdAt: inventory.createdAt,
      medicine: medicine,
      supplier: supplier,
    );
  }
}
