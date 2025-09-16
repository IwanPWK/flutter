import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Akses DAO melalui database instance
final authorDaoProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return database.authorDao; // Generated getter dari Drift
});

final categoryDaoProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return database.categoryDao; // Generated getter dari Drift
});

final bookDaoProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return database.bookDao; // Generated getter dari Drift
});

final bookAuthorDaoProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return database.bookAuthorDao; // Generated getter dari Drift
});
