//24:00

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin_dashboard/controllers/dashboard_controller.dart';
import 'package:flutter_ecommerce_admin_dashboard/views/widgets/customers_section.dart';
import 'package:flutter_ecommerce_admin_dashboard/views/widgets/inventory_section.dart';
import 'package:flutter_ecommerce_admin_dashboard/views/widgets/orders_section.dart';
import 'package:flutter_ecommerce_admin_dashboard/views/widgets/product_section.dart';
import 'package:flutter_ecommerce_admin_dashboard/views/widgets/sales_section.dart';
import 'package:flutter_ecommerce_admin_dashboard/views/widgets/statistics_section.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  final DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEBEE),
      body: Row(
        children: [
          Obx(
            () => AnimatedContainer(
              width: controller.sidebarOpen.value ? 200 : 60,
              color: Color(0xFFD32F2F),
              duration: const Duration(milliseconds: 300),
              child: _buildSideBar(),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [_buildHeader(), Expanded(child: _buildContent())],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.sidebarOpen.value) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Main Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
        Obx(
          () => Column(
            children: List.generate(
              controller.sections.length,
              (index) => _buildSidebarItem(
                controller.sections[index].icon,
                controller.sections[index].title,
                index,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    return Obx(() {
      final isSelected = controller.currentSectionIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeSection(index),
        child: Container(
          color: Color(0xFFD32F2F),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Color(0xFFD32F2F),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: isSelected ? Color(0xFFB71C1C) : Colors.white,
                      ),
                      if (controller.sidebarOpen.value) SizedBox(width: 15),
                      if (controller.sidebarOpen.value)
                        Text(
                          title,
                          style: TextStyle(
                            color:
                                isSelected ? Color(0xFFB71C1C) : Colors.white,
                            fontWeight:
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => controller.toggleSidebar(),
            child: Icon(Icons.menu),
          ),
          SizedBox(width: 10),
          Text(
            'Welcome Back, Kurniawan Wijaya',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.logout, color: Color(0xFFB71C1C), size: 30),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      switch (controller.currentSectionIndex.value) {
        case 0:
          return StatisticsSection();
        case 1:
          return ProductSection();
        case 2:
          return OrdersSection();
        case 3:
          return CustomersSection();
        case 4:
          return InventorySection();
        case 5:
          return SalesSection();
        default:
          return Center(child: Text('Data Not Found'));
      }
    });
  }
}
