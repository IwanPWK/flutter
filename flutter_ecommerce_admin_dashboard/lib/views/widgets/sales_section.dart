import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin_dashboard/controllers/sales_controller.dart';
import 'package:get/get.dart';

class SalesSection extends StatefulWidget {
  const SalesSection({super.key});

  @override
  State<SalesSection> createState() => _SalesSectionState();
}

class _SalesSectionState extends State<SalesSection> {
  final SalesController controller = Get.put(SalesController());
  bool _ascending = true;
  String _sortColumn = 'salesId';
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
              'Sales Overview',
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
        _BuildCard("Total Sales", "500", Icons.attach_money, Colors.blueAccent),
        _BuildCard(
          "Total Revenue",
          "\$50,000",
          Icons.money,
          Colors.greenAccent,
        ),
        _BuildCard(
          "Avg Order Value",
          "\$500",
          Icons.bar_chart,
          Colors.orangeAccent,
        ),
        _BuildCard("Sales Growth", "15%", Icons.trending_up, Colors.redAccent),
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
                labelText: 'Search Sales',
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
                'salesId',
                'totalAmount',
                'orderCount',
                'date',
                'growth',
              ].indexOf(_sortColumn),
              sortAscending: _ascending,
              columns: [
                _buildDataColumn("Sales Id", 'salesId'),
                _buildDataColumn("Total Amount", 'totalAmount', numeric: true),
                _buildDataColumn("Order Count", 'orderCount', numeric: true),
                _buildDataColumn("Date", 'date'),
                _buildDataColumn("Growth", 'growth', numeric: true),
              ],
              rows: data.map((item) => _buildDataRow(item)).toList(),
            ),
          );
        },
      ),
    );
  }

  DataColumn _buildDataColumn(
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

  DataRow _buildDataRow(Map<String, dynamic> item) {
    return DataRow(
      cells: [
        DataCell(Text(item['salesId']?.toString() ?? "N/A")),
        DataCell(Text(item['totalAmount']?.toString() ?? "N/A")),
        DataCell(Text(item['orderCount']?.toString() ?? "N/A")),
        DataCell(Text(item['date']?.toString() ?? "N/A")),
        DataCell(Text(item['growth']?.toString() ?? "N/A")),
      ],
    );
  }

  List<Map<String, dynamic>> _applyFilers(List<Map<String, dynamic>> data) {
    String searchText = _searchController.text.toLowerCase();

    return data.where((item) {
      if (searchText.isNotEmpty &&
          !item['salesId'].toString().toLowerCase().contains(searchText))
        return false;
      return true;
    }).toList();
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("1-50 of 100 Salesmans", style: TextStyle(color: Colors.grey)),
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
