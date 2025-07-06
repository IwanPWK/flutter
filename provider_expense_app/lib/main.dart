import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_expense_app/models/database_provider.dart';
import 'package:provider_expense_app/screens/all_expenses.dart';
import 'package:provider_expense_app/screens/category_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DatabaseProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expense App',
      debugShowCheckedModeBanner: false,
      initialRoute: CategoryScreen.name,
      routes: {
        CategoryScreen.name: (_) => const CategoryScreen(),
        AllExpenses.name: (_) => const AllExpenses(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
