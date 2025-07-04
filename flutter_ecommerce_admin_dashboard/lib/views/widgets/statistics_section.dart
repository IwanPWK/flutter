import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_admin_dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
            _BuildDashboardCards(),
            SizedBox(height: 30),
            _BuildChartsRow(),
            SizedBox(height: 30),
            _BuildFilters(),
            SizedBox(height: 30),
            _BuildDataTable(),
          ],
        ),
      ),
    );
  }

  Widget _BuildDashboardCards() {
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

  Widget _BuildChartsRow() {
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

  Widget _BuildFilters() {
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

  Widget _BuildDataTable() {
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
        },
      ),
    );
  }

  List<Map<String, dynamic>> _applyFilers(List<Map<String, dynamic>> data) {
    String searchText = _searchController.text.toLowerCase();

    var filteredData =
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
  }
}
