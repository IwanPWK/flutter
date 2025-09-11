import 'package:drift/drift.dart';
import '../models/task_with_user.dart';
import 'app_database.dart';
import 'tables.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Users, Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.db);

  // LEFT JOIN: semua task tampil, user bisa null
  Stream<List<TaskWithUser>> watchTasksWithUsers() {
    final query = select(
      tasks,
    ).join([leftOuterJoin(users, users.id.equalsExp(tasks.userId))]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return TaskWithUser(
          task: row.readTable(tasks),
          user: row.readTableOrNull(users),
        );
      }).toList();
    });
  }

  // Insert contoh
  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);
  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);
}
