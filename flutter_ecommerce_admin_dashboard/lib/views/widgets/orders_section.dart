import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin_dashboard/controllers/orders_controller.dart';
import 'package:get/get.dart';

class OrdersSection extends StatefulWidget {
  const OrdersSection({super.key});

  @override
  State<OrdersSection> createState() => _OrdersSectionState();
}

class _OrdersSectionState extends State<OrdersSection> {
  final OrdersController controller = Get.put(OrdersController());
  bool _ascending = true;
  String _sortColumn = 'orderId';
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orders Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildDashboardCards(),
            SizedBox(height: 30),
            _buildFilters(),
            SizedBox(height: 30),
            _buildDataTable(),
            SizedBox(height: 20),
            _buildPagination(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _BuildCard("Total Orders", "500", Icons.list_alt, Colors.blueAccent),
        _BuildCard(
          "Delivered Orders",
          "300",
          Icons.check_circle,
          Colors.greenAccent,
        ),
        _BuildCard("Pending Orders", "150", Icons.pending, Colors.orangeAccent),
        _BuildCard("Cancelled Orders", "50", Icons.cancel, Colors.redAccent),
      ],
    );
  }

  Widget _BuildCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 30, color: color),
                  SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Search Order',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[100],
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: controller.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text("Something Went Wrong"));
          }
          final data = _applyFilers(snapshot.data!);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: [
                'orderId',
                'customerName',
                'totalAmount',
                'orderDate',
                'status',
              ].indexOf(_sortColumn),
              sortAscending: _ascending,
              columns: [
                _BuildDataColumn("Order ID", 'orderId'),
                _BuildDataColumn("Customer Name", 'customerName'),
                _BuildDataColumn("Total Amount", 'totalAmount', numeric: true),
                _BuildDataColumn("Order Date", 'orderDate'),
                _BuildDataColumn("Status", 'status'),
              ],
              rows: data.map((item) => _BuildDataRow(item)).toList(),
            ),
          );
        },
      ),
    );
  }

  DataColumn _BuildDataColumn(
    String label,
    String key, {
    bool numeric = false,
  }) {
    return DataColumn(
      label: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      numeric: numeric,
      onSort: (columnIndex, ascending) {
        setState(() {
          _sortColumn = key;
          _ascending = ascending;
        });
      },
    );
  }

  DataRow _BuildDataRow(Map<String, dynamic> item) {
    return DataRow(
      cells: [
        DataCell(Text(item['orderId']?.toString() ?? "N/A")),
        DataCell(Text(item['customerName']?.toString() ?? "N/A")),
        DataCell(Text(item['totalAmount']?.toString() ?? "N/A")),
        DataCell(Text(item['orderDate']?.toString() ?? "N/A")),
        DataCell(Text(item['status']?.toString() ?? "N/A")),
      ],
    );
  }

  List<Map<String, dynamic>> _applyFilers(List<Map<String, dynamic>> data) {
    String searchText = _searchController.text.toLowerCase();

    return data.where((item) {
      if (searchText.isNotEmpty &&
          !item['customerName'].toString().toLowerCase().contains(searchText))
        return false;
      return true;
    }).toList();
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("1-50 of 500 orders"),
        SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.chevron_left, color: Colors.grey),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text("1", style: TextStyle(color: Colors.white)),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.chevron_right, color: Colors.redAccent),
        ),
      ],
    );
  }
}
