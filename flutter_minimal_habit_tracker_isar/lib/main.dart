import 'package:flutter/material.dart';
import 'package:flutter_minimal_habit_tracker_isar/database/habit.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();
  runApp(
    MultiProvider(
      providers: [
        // habit provider
        ChangeNotifierProvider(create: (_) => HabitDatabase()),

        // theme provider
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: Provider.of<ThemeProvider>(context).getTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
