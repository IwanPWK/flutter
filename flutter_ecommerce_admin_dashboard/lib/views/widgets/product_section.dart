import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin_dashboard/controllers/product_controller.dart';
import 'package:get/get.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key});

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  final ProductController controller = Get.put(ProductController());
  bool _ascending = true;
  String _sortColumn = 'productName';
  String _filterCategory = "All";
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
              'Products Overview',
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
        _BuildCard(
          "Total Products",
          "5,000",
          Icons.inventory,
          Colors.orangeAccent,
        ),
        _BuildCard("Out of Stock", "500", Icons.warning, Colors.redAccent),
        _BuildCard("New Products", "30", Icons.new_releases, Colors.blueAccent),
        _BuildCard("Categories", "20", Icons.category, Colors.greenAccent),
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
                labelText: 'Search Product',
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
          SizedBox(width: 16),
          DropdownButton<String>(
            value: _filterCategory,
            onChanged: (value) => setState(() => _filterCategory = value!),
            underline: Container(),
            icon: Icon(Icons.filter_list),
            style: TextStyle(color: Colors.black87, fontSize: 16),
            items:
                [
                      'All',
                      'Category 0',
                      'Category 1',
                      'Category 2',
                      'Category 3',
                      'Category 4',
                      'Category 5',
                    ]
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
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
                'productName',
                'category',
                'stock',
                'price',
                'sku',
              ].indexOf(_sortColumn),
              sortAscending: _ascending,
              columns: [
                _BuildDataColumn("Product Name", 'productName'),
                _BuildDataColumn("Category", 'category'),
                _BuildDataColumn("Stock", 'stock', numeric: true),
                _BuildDataColumn("Price", 'price', numeric: true),
                _BuildDataColumn("SKU", 'sku'),
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
        DataCell(Text(item['productName']?.toString() ?? "N/A")),
        DataCell(Text(item['category']?.toString() ?? "N/A")),
        DataCell(Text(item['stock']?.toString() ?? "N/A")),
        DataCell(Text(item['price']?.toString() ?? "N/A")),
        DataCell(Text(item['sku']?.toString() ?? "N/A")),
      ],
    );
  }

  List<Map<String, dynamic>> _applyFilers(List<Map<String, dynamic>> data) {
    String searchText = _searchController.text.toLowerCase();

    var filterData =
        data.where((item) {
          if (_filterCategory != 'All' && item['category'] != _filterCategory)
            return false;
          if (searchText.isNotEmpty &&
              !item['productName'].toString().toLowerCase().contains(
                searchText,
              ))
            return false;
          return true;
        }).toList();

    filterData.sort((a, b) {
      var aValue = a[_sortColumn];
      var bValue = b[_sortColumn];
      if (aValue is String && bValue is String) {
        return _ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      } else if (aValue is num && bValue is num) {
        return _ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      }
      return 0;
    });
    return filterData;
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("1-5 of 5 items"),
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
