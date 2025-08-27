import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartRing extends StatelessWidget {
  const ChartRing({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195,
      width: 195,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: 195,
              width: 195,
              child: Center(
                child: SfCircularChart(
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: chartData,
                      innerRadius: "85%",
                      startAngle: 350,
                      endAngle: 350,
                      cornerStyle: CornerStyle.bothCurve,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, _) => data.color,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: 195,
              width: 195,
              child: Center(
                child: Text(
                  "24.9%",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<ChartData> chartData = <ChartData>[
  ChartData('Fever', 20, secondaryColor),
  ChartData('Common Cold', 40, secondaryColor2),
  ChartData('Allergy', 60, Color(0xFF01DFFF)),
  ChartData('Headache', 80, Color(0xFF4FF0B4)),
  ChartData('Cough', 100, Color(0xFFF9A266)),
  ChartData('Vomiting', 100, Color(0xFFF9CE62)),
];

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
