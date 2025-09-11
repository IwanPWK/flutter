import 'package:flutter/material.dart';
import 'data/app_database.dart';
import 'models/task_with_user.dart';

late final AppDatabase db;

void main() {
  db = AppDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Drift Join Demo', home: TaskPage());
  }
}

class TaskPage extends StatelessWidget {
  TaskPage({super.key});

  final dao = db.taskDao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks with Users")),
      body: StreamBuilder<List<TaskWithUser>>(
        stream: dao.watchTasksWithUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text("No tasks found"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return ListTile(
                title: Text(item.task.title),
                subtitle: Text("Owner: ${item.user?.username ?? 'Unknown'}"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // contoh insert data cepat
          final userId = await dao.insertUser(
            UsersCompanion.insert(username: "Alice"),
          );
          await dao.insertTask(
            TasksCompanion.insert(title: "Belajar Drift", userId: userId),
          );
        },
      ),
    );
  }
}
