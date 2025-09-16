import 'package:drift/drift.dart';
import '../database.dart';
import '../../models/book_models.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase> with _$CategoryDaoMixin {
  CategoryDao(AppDatabase db) : super(db);

  Future<List<CategoryModel>> getAllCategories() async {
    final categoriesList = await select(categories).get(); // renamed
    return categoriesList.map((category) => CategoryModel(
      id: category.id,
      name: category.name,
      description: category.description,
      createdAt: category.createdAt,
    )).toList();
  }

  Future<CategoryModel?> getCategoryById(int id) async {
    final category = await (select(categories)..where((c) => c.id.equals(id))).getSingleOrNull();
    if (category == null) return null;
    
    return CategoryModel(
      id: category.id,
      name: category.name,
      description: category.description,
      createdAt: category.createdAt,
    );
  }

  Future<CategoryModel> createCategory(CategoryModel category) async {
    final id = await into(categories).insert(CategoriesCompanion(
      name: Value(category.name),
      description: Value(category.description),
    ));
    
    return category.copyWith(id: id);
  }

  Future<bool> updateCategory(CategoryModel category) async {
    final result = await (update(categories)..where((c) => c.id.equals(category.id!)))
        .write(CategoriesCompanion(
          name: Value(category.name),
          description: Value(category.description),
        ));
    return result > 0; // Convert int to bool
  }

  Future<int> deleteCategory(int id) async {
    return await (delete(categories)..where((c) => c.id.equals(id))).go();
  }
}
