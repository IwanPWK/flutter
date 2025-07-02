import 'package:flutter/material.dart';
import 'package:flutter_bar_charts/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RangeColumnCharts extends StatelessWidget {
  const RangeColumnCharts({super.key});

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
              children: [
                Text(
                  'Population',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(Icons.menu, color: Color(0xFF0A9396), size: 24),
              ],
            ),
            SizedBox(height: defaultPadding * 2),
            SfCartesianChart(
              plotAreaBackgroundColor: Colors.transparent,
              margin: EdgeInsets.all(0),
              borderColor: Colors.transparent,
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              enableSideBySideSeriesPlacement: false,
              primaryXAxis: CategoryAxis(isVisible: false),
              primaryYAxis: NumericAxis(
                isVisible: false,
                minimum: 0,
                maximum: 2,
                interval: 0.5,
              ),
              series: <CartesianSeries>[
                RangeColumnSeries<ChartColumnData, String>(
                  borderRadius: BorderRadius.circular(20.0),
                  dataSource: chartData,
                  isTrackVisible: true,
                  trackBorderWidth: 0,
                  trackColor: Color(0xFFE9EDF7),
                  width: 0.5,
                  color: Color(0xFFF72585),
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  highValueMapper: (ChartColumnData data, _) => data.high1,
                  lowValueMapper: (ChartColumnData data, _) => data.low1,
                ),
                RangeColumnSeries<ChartColumnData, String>(
                  borderRadius: BorderRadius.circular(20.0),
                  dataSource: chartData,
                  width: 0.5,
                  color: Color(0xFFF7209B7),
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  highValueMapper: (ChartColumnData data, _) => data.high2,
                  lowValueMapper: (ChartColumnData data, _) => data.low2,
                ),
                RangeColumnSeries<ChartColumnData, String>(
                  borderRadius: BorderRadius.circular(20.0),
                  dataSource: chartData,
                  width: 0.5,
                  color: Color(0xFF4CC9F0),
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  highValueMapper: (ChartColumnData data, _) => data.high3,
                  lowValueMapper: (ChartColumnData data, _) => data.low3,
                ),
                RangeColumnSeries<ChartColumnData, String>(
                  borderRadius: BorderRadius.circular(20.0),
                  dataSource: chartData,
                  width: 0.5,
                  color: Color(0xFFF72585),
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  highValueMapper: (ChartColumnData data, _) => data.high4,
                  lowValueMapper: (ChartColumnData data, _) => data.low4,
                ),
              ],
            ),
            SizedBox(height: defaultPadding * 2),
            Row(
              children: [
                Container(
                  width: 27,
                  height: 13,
                  decoration: BoxDecoration(
                    color: Color(0xFFF72585),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '2010',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: defaultPadding),
                Container(
                  width: 27,
                  height: 13,
                  decoration: BoxDecoration(
                    color: Color(0xFF7209B7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(width: 10),

                Text(
                  '2011',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: defaultPadding),
                Container(
                  width: 27,
                  height: 13,
                  decoration: BoxDecoration(
                    color: Color(0xFF4CC9F0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '2012',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: defaultPadding * 2),
              ],
            ),
            Text(
              'Historic World Population',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartColumnData {
  ChartColumnData(
    this.x,
    this.low1,
    this.high1,
    this.low2,
    this.high2,
    this.low3,
    this.high3,
    this.low4,
    this.high4,
  );
  final String x;
  final double low1;
  final double high1;
  final double low2;
  final double high2;
  final double low3;
  final double high3;
  final double low4;
  final double high4;
}

final List<ChartColumnData> chartData = <ChartColumnData>[
  ChartColumnData('China', 0, 0.8, 0.8, 1.3, 1.3, 1.5, 1.5, 1.75),
  ChartColumnData('India', 0, 1, 1, 1.2, 1.2, 1.8, 1.8, 2),
  ChartColumnData('Russia', 0, 1.2, 1.2, 1.7, 0, 0, 1.7, 1.85),
  ChartColumnData('Japan', 0, 1, 1, 1.2, 1.2, 1.8, 1.8, 2),
  ChartColumnData('Bangladesh', 0, 1.2, 1.2, 1.7, 0, 0, 1.7, 1.85),
  ChartColumnData('Italy', 0, 0.8, 0.8, 1.3, 1.3, 1.5, 1.5, 1.75),
  ChartColumnData('Germany', 0, 0.25, 0.25, 0.6, 0.6, 1.7, 1.7, 1.85),
  ChartColumnData('Indonesia', 0, 0.8, 0.8, 1.3, 1.3, 1.5, 1.5, 1.75),
  ChartColumnData('Pakistan', 0, 0.8, 0.8, 1.3, 1.3, 1.5, 1.5, 1.75),
  ChartColumnData('Spain', 0, 0.25, 0.25, 0.6, 0.6, 1.7, 1.7, 1.85),
  ChartColumnData('Algeria', 0, 0.25, 0.25, 0.6, 0.6, 1.7, 1.7, 1.85),
];
