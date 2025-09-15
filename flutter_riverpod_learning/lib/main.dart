import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'notifier_provider/enum_activity/enum_activity_page.dart';
import 'notifier_provider/pages/counter/counter_page_notifier.dart';
import 'notifier_provider/pages/counter/counter_page_notifier_family.dart';
import 'pages/family_dispose/family_dispose_page.dart';
import 'pages/todos/todos_page.dart';
import 'pages/users/user_list_page.dart';
import 'widgets/custom_button.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Learning'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: const [
            CustomButton(
              title: 'User List',
              child: UserListPage(),
            ),
            CustomButton(
              title: 'Family Dispose',
              child: FamilyDisposePage(),
            ),
            CustomButton(
              title: 'Todos Simple App',
              child: TodosPage(),
            ),
            CustomButton(
              title: 'Counter Notifier App',
              child: CounterPage(),
            ),
            CustomButton(
              title: 'Counter Notifier Family App',
              child: CounterFamilyPage(),
            ),
            CustomButton(
              title: 'Enum Activity',
              child: EnumActivityPage(),
            ),
          ],
        ),
      ),
    );
  }
}