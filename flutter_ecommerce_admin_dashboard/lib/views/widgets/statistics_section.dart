import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin_dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StatisticsSection extends StatefulWidget {
  const StatisticsSection({super.key});

  @override
  State<StatisticsSection> createState() => _StatisticsSectionState();
}

class _StatisticsSectionState extends State<StatisticsSection> {
  final DashboardController controller = Get.put(DashboardController());
  bool _ascending = true;
  String _sortColumn = 'sales';
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
              'Dashboard Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildDashboardCards(),
            SizedBox(height: 30),
            _buildChartsRow(),
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
          "Total Revenue",
          "\$25,000",
          Icons.attach_money,
          Colors.greenAccent,
        ),
        _BuildCard(
          "Avg Order Value",
          "\$100",
          Icons.bar_chart,
          Colors.blueAccent,
        ),
        _BuildCard(
          "Total Customers",
          "1500",
          Icons.people,
          Colors.purpleAccent,
        ),
        _BuildCard(
          "Total Products",
          "500",
          Icons.inventory,
          Colors.orangeAccent,
        ),
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

  Widget _buildChartsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 350, child: _BuildLineChart()),
        SizedBox(width: 350, child: _BuildBarChart()),
        SizedBox(width: 350, child: _BuildPieChart()),
        // Expanded(child: Placeholder()),
        // Expanded(child: Placeholder()),
      ],
    );
  }

  Widget _BuildLineChart() {
    return _BuildChartContainer(
      title: "Sales Trend",
      chart: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget:
                    (value, meta) => Text(
                      ['Jan', 'Feb', 'Mar', 'Apr', 'May'][value.toInt()],
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget:
                    (value, meta) => Text(
                      '${value.toInt()}K',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1),
                FlSpot(1, 1.5),
                FlSpot(2, 2),
                FlSpot(3, 2.5),
                FlSpot(4, 3),
              ],
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withValues(alpha: 0.1),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  final flSpot = barSpot;
                  return LineTooltipItem(
                    '${flSpot.y}K',
                    TextStyle(color: Colors.white),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _BuildBarChart() {
    return _BuildChartContainer(
      title: 'Category Sales',
      chart: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          barTouchData: BarTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  rod.toY.round().toString(),
                  TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  const titles = ['A', 'B', 'C', 'D'];
                  return Text(
                    titles[value.toInt()],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}K',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [BarChartRodData(toY: 10, color: Colors.blueAccent)],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [BarChartRodData(toY: 12, color: Colors.blueAccent)],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [BarChartRodData(toY: 14, color: Colors.blueAccent)],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [BarChartRodData(toY: 8, color: Colors.blueAccent)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _BuildPieChart() {
    return _BuildChartContainer(
      title: 'Revenue Distribution',
      chart: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 50,
          sections: [
            PieChartSectionData(
              value: 40,
              color: Colors.blueAccent,
              title: '40%',
              titleStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              // radius: 20,
              showTitle: true,
            ),
            PieChartSectionData(
              value: 30,
              color: Colors.green,
              title: '30%',
              titleStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              // radius: 20,
              showTitle: true,
            ),
            PieChartSectionData(
              value: 20,
              color: Colors.orange,
              title: '20%',
              titleStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              // radius: 20,
              showTitle: true,
            ),
            PieChartSectionData(
              value: 10,
              color: Colors.redAccent,
              title: '10%',
              titleStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              // radius: 20,
              showTitle: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _BuildChartContainer({required String title, required Widget chart}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SizedBox(height: 200, child: chart),
        ],
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
                'sales',
                'stock',
                'totalRevenue',
                'averageOrderValue',
                'dateAdded',
              ].indexOf(_sortColumn),
              sortAscending: _ascending,
              columns: [
                _BuildDataColumn("Product Name", 'productName'),
                _BuildDataColumn("Category", 'category'),
                _BuildDataColumn("Sales", 'sales', numeric: true),
                _BuildDataColumn("Stock", 'stock', numeric: true),
                _BuildDataColumn(
                  "Total Revenue",
                  'totalRevenue',
                  numeric: true,
                ),
                _BuildDataColumn(
                  "Avg Order Value",
                  'averageOrderValue',
                  numeric: true,
                ),
                _BuildDataColumn("Date Added", 'dateAdded'),
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
    String formatNumber(dynamic value) {
      if (value is num) {
        return NumberFormat('#,###').format(value);
      }
      return value.toString();
    }

    String formatCurrency(dynamic value) {
      if (value == null) return "N/A";
      if (value is num) {
        return '\$${NumberFormat('#,###.00').format(value)}';
      }
      return value.toString();
    }

    String formatDate(dynamic value) {
      if (value == null) return "N/A";
      try {
        return DateFormat(
          'MMM d, yyy',
        ).format(DateTime.parse(value.toString()));
      } catch (e) {
        return value.toString();
      }
    }

    return DataRow(
      cells: [
        DataCell(Text(item['productName']?.toString() ?? "N/A")),
        DataCell(Text(item['category']?.toString() ?? "N/A")),
        DataCell(Text(formatNumber(item['sales']))),
        DataCell(Text(formatNumber(item['stock']))),
        DataCell(Text(formatCurrency(item['totalRevenue']))),
        DataCell(Text(formatCurrency(item['averageOrderValue']))),
        DataCell(Text(formatDate(item['dateAdded']))),
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
        Text("1-10 of 50 items"),
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
