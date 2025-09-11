import 'package:riverpod/riverpod.dart';
import '../database/database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final bukuDaoProvider = Provider<BukuDao>((ref) {
  final db = ref.watch(databaseProvider);
  return BukuDao(db);
});

// State Notifier untuk CRUD
final bukuListProvider = StreamProvider.autoDispose<List<BukuGabungan>>((ref) {
  final dao = ref.watch(bukuDaoProvider);
  return dao.watchAllBukuGabungan();
});
