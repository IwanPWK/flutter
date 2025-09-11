import '../data/app_database.dart';

class TaskWithUser {
  final Task task;
  final User? user;

  TaskWithUser({required this.task, this.user});
}
