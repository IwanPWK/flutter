//08:30

import 'package:flutter/material.dart';
import 'package:flutter_bar_charts/constants.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FloatingRangeColumnCharts extends StatefulWidget {
  const FloatingRangeColumnCharts({super.key});

  @override
  State<FloatingRangeColumnCharts> createState() =>
      _FloatingRangeColumnChartsState();
}

class _FloatingRangeColumnChartsState extends State<FloatingRangeColumnCharts> {
  String selectedChips = '3 d';

  List<String> chips = ['24h', '1 d', '3 d', '1 w', '3 w', '1 m'];
  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      surfaceTintColor: secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Statistic',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Minim dolorem ipsum dolor sit amet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(Icons.menu),
                ),
              ],
            ),
            SizedBox(height: defaultPadding * 2),
            SfCartesianChart(
              margin: EdgeInsets.symmetric(
                vertical: defaultPadding * 2,
                horizontal: defaultPadding / 2,
              ),
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(isVisible: false),
              primaryYAxis: NumericAxis(
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
                majorGridLines: const MajorGridLines(
                  width: 1,
                  color: Colors.black,
                  dashArray: <double>[5, 5],
                ),
                numberFormat: NumberFormat.compact(),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                minimum: 0,
                maximum: 8000,
                interval: 2000,
              ),
              series: <CartesianSeries<ChartColumnData, String>>[
                RangeColumnSeries<ChartColumnData, String>(
                  borderRadius: BorderRadius.circular(20),
                  dataSource: chartData,
                  width: 0.6,
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  lowValueMapper: (ChartColumnData data, _) => data.low,
                  highValueMapper: (ChartColumnData data, _) => data.high,
                  pointColorMapper: (ChartColumnData data, _) => data.color,
                ),
              ],
            ),
            SizedBox(height: defaultPadding),
            Text('Year 2024', style: TextStyle(color: Colors.grey)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 2,
                vertical: defaultPadding,
              ),
              child: FittedBox(
                child: Wrap(
                  spacing: 0,
                  children:
                      chips.map((category) {
                        return ChoiceChip(
                          label: Text(category),
                          labelStyle: TextStyle(
                            color:
                                selectedChips.contains(category)
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          selectedColor: Color(0xFFE210B4),
                          backgroundColor: Colors.grey.shade200,
                          showCheckmark: false,
                          selected: selectedChips.contains(category),
                          side: BorderSide(width: 0, color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedChips = category;
                              }
                            });
                          },
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartColumnData {
  ChartColumnData(this.x, this.low, this.high, this.color);
  final String x;
  final double? low;
  final double? high;
  final Color? color;
}

final List<ChartColumnData> chartData = <ChartColumnData>[
  ChartColumnData("Mo", 2600, 5000, const Color(0xFFFFD60A)),
  ChartColumnData("Tu", 1800, 3000, const Color(0xFF4361EE)),
  ChartColumnData("We", 3200, 6000, const Color(0xFFFFD60A)),
  ChartColumnData("Th", 3800, 500, const Color(0xFF4361EE)),
  ChartColumnData("Fr", 300, 4800, const Color(0xFFE210B4)),
  ChartColumnData("Sa", 2200, 7800, const Color(0xFF4361EE)),
  ChartColumnData("Su", 1800, 4800, const Color(0xFFFFD60A)),
  ChartColumnData("Su2", 2000, 5800, const Color(0xFF4361EE)),
  ChartColumnData("Su3", 3000, 4200, const Color(0xFFFFD60A)),
];
