import 'package:drift/drift.dart';

class NoteTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description =>
      text().nullable().withLength(min: 1, max: 1000)();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
