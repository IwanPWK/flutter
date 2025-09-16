// lib/database/daos/category_dao.dart
import 'package:drift/drift.dart';
import '../pharmacy_database.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<PharmacyDatabase> with _$CategoryDaoMixin {
  CategoryDao(super.db);

  // READ - Get all categories
  Future<List<Category>> getAllCategories() {
    return select(categories).get();
  }

  // READ - Get category by ID
  Future<Category?> getCategoryById(int id) {
    return (select(categories)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  // CREATE - Insert new category
  Future<int> insertCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  // UPDATE - Update category
  Future<int> updateCategory(int id, CategoriesCompanion category) {
    return (update(categories)..where((c) => c.id.equals(id))).write(category);
  }

  // DELETE - Delete category
  Future<int> deleteCategory(int id) {
    return (delete(categories)..where((c) => c.id.equals(id))).go();
  }
}
