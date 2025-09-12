import 'package:riverpod/riverpod.dart';
import '../database/app_database.dart';
import '../database/dao.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final categoryDaoProvider = Provider<CategoryDao>((ref) {
  return ref.read(databaseProvider).categoryDao;
});

final supplierDaoProvider = Provider<SupplierDao>((ref) {
  return ref.read(databaseProvider).supplierDao;
});

final productDaoProvider = Provider<ProductDao>((ref) {
  return ref.read(databaseProvider).productDao;
});

final stockDaoProvider = Provider<StockDao>((ref) {
  return ref.read(databaseProvider).stockDao;
});

final stockListProvider = FutureProvider<List<StockWithDetail>>((ref) {
  final stockDao = ref.watch(stockDaoProvider);
  return stockDao.getAllWithDetail();
});
