import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin_dashboard/controllers/dashboard_controller.dart';
import 'package:flutter_ecommerce_admin_dashboard/views/dashboard.dart';
import 'package:get/get.dart';

Future<void> main() async {
  Get.put(DashboardController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: Dashboard(),
    );
  }
}
