import 'package:drift/drift.dart';
import 'app_database.dart';

part 'dao.g.dart';

// -------------------- CATEGORY DAO --------------------
@DriftAccessor(tables: [Categories])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  final AppDatabase db;
  CategoryDao(this.db) : super(db);

  Future<List<Category>> getAll() => select(categories).get();
  Future<int> insertCategory(CategoriesCompanion entry) =>
      into(categories).insert(entry);
  Future<bool> updateCategory(Category entry) =>
      update(categories).replace(entry);
  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
}

// -------------------- SUPPLIER DAO --------------------
@DriftAccessor(tables: [Suppliers])
class SupplierDao extends DatabaseAccessor<AppDatabase>
    with _$SupplierDaoMixin {
  final AppDatabase db;
  SupplierDao(this.db) : super(db);

  Future<List<Supplier>> getAll() => select(suppliers).get();
  Future<int> insertSupplier(SuppliersCompanion entry) =>
      into(suppliers).insert(entry);
  Future<bool> updateSupplier(Supplier entry) =>
      update(suppliers).replace(entry);
  Future<int> deleteSupplier(int id) =>
      (delete(suppliers)..where((tbl) => tbl.id.equals(id))).go();
}

// -------------------- PRODUCT DAO --------------------
@DriftAccessor(tables: [Products, Categories])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  final AppDatabase db;
  ProductDao(this.db) : super(db);

  Future<List<Product>> getAll() => select(products).get();
  Future<int> insertProduct(ProductsCompanion entry) =>
      into(products).insert(entry);
  Future<bool> updateProduct(Product entry) => update(products).replace(entry);
  Future<int> deleteProduct(int id) =>
      (delete(products)..where((tbl) => tbl.id.equals(id))).go();
}

// -------------------- STOCK DAO --------------------
class StockWithDetail {
  final Stock stock;
  final Product product;
  final Category category;
  final Supplier supplier;

  StockWithDetail(this.stock, this.product, this.category, this.supplier);
}

@DriftAccessor(tables: [Stocks, Products, Categories, Suppliers])
class StockDao extends DatabaseAccessor<AppDatabase> with _$StockDaoMixin {
  final AppDatabase db;
  StockDao(this.db) : super(db);

  Future<List<StockWithDetail>> getAllWithDetail() async {
    final query = select(stocks).join([
      innerJoin(products, products.id.equalsExp(stocks.productId)),
      innerJoin(categories, categories.id.equalsExp(products.categoryId)),
      innerJoin(suppliers, suppliers.id.equalsExp(stocks.supplierId)),
    ]);

    final rows = await query.get();
    return rows.map((row) {
      return StockWithDetail(
        row.readTable(stocks),
        row.readTable(products),
        row.readTable(categories),
        row.readTable(suppliers),
      );
    }).toList();
  }

  Future<int> insertStock(StocksCompanion entry) => into(stocks).insert(entry);
  Future<bool> updateStock(Stock entry) => update(stocks).replace(entry);
  Future<int> deleteStock(int id) =>
      (delete(stocks)..where((tbl) => tbl.id.equals(id))).go();
}
