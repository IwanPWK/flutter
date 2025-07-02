import 'package:flutter/material.dart';
import 'package:flutter_bar_charts/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VerticalBarCharts extends StatelessWidget {
  const VerticalBarCharts({super.key});

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
              children: [
                Text(
                  '854',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: defaultPadding),
                const Icon(Icons.arrow_upward, color: Color(0xFF0A9396)),
                const Text(
                  '25 upward',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0A9396),
                  ),
                ),
                Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, size: 40),
                ),
              ],
            ),
            SfCartesianChart(
              plotAreaBackgroundColor: Colors.transparent,
              margin: EdgeInsets.symmetric(vertical: defaultPadding * 2),
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
                ColumnSeries<ChartColumnData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  yValueMapper: (ChartColumnData data, _) => data.y,
                  color: Color(0xFFE9EDF7),
                  width: 0.5,
                  borderRadius: BorderRadius.circular(20),
                ),
                ColumnSeries<ChartColumnData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  yValueMapper: (ChartColumnData data, _) => data.y1,
                  color: Color(0xFF0A9396),
                  width: 0.5,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            ),
            Text(
              'Vertical Bar Chart',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Minim dolorem ipsum dolor sit amet',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartColumnData {
  ChartColumnData(this.x, this.y, this.y1);
  final String x;
  final double y;
  final double y1;
}

final List<ChartColumnData> chartData = <ChartColumnData>[
  ChartColumnData("Mo", 2, 1),
  ChartColumnData("Tu", 2, 0.5),
  ChartColumnData("We", 2, 1.5),
  ChartColumnData("Th", 2, 0.8),
  ChartColumnData("Fr", 2, 1.3),
  ChartColumnData("Sa", 2, 1.8),
  ChartColumnData("Su", 2, 0.9),
];
