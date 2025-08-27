import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/note_table.dart';

part 'note_dao.g.dart';

@DriftAccessor(tables: [NoteTable])
class NoteDao extends DatabaseAccessor<AppDatabase> with _$NoteDaoMixin {
  NoteDao(super.db);

  Future<List<NoteTableData>> getAllNotes() {
    return select(noteTable).get();
  }

  // watch all the notes
  Stream<List<NoteTableData>> watchAllNotes() {
    return (select(noteTable)..orderBy([
      (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
    ])).watch();
  }
}
