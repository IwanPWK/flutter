import 'package:flutter/material.dart';
import 'package:flutter_bar_charts/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CommonVerticalBarCharts extends StatefulWidget {
  const CommonVerticalBarCharts({super.key});

  @override
  State<CommonVerticalBarCharts> createState() =>
      _CommonVerticalBarChartsState();
}

class _CommonVerticalBarChartsState extends State<CommonVerticalBarCharts> {
  String selectedChips = 'Dec';

  List<String> chips = ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      surfaceTintColor: secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Text(
                            'Stacked Column Chart',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: defaultPadding * 2),
                    Expanded(flex: 2, child: Icon(Icons.add_chart_rounded)),
                  ],
                ),
                SizedBox(height: defaultPadding),
                FittedBox(
                  child: Wrap(
                    spacing: 10,
                    children:
                        chips
                            .map(
                              (category) => ChoiceChip(
                                label: Text(category),
                                labelStyle: TextStyle(color: Colors.black),
                                selectedColor: Colors.grey.shade200,
                                backgroundColor: Colors.white,
                                showCheckmark: false,
                                selected: selectedChips.contains(category),
                                side: BorderSide(width: 0, color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onSelected:
                                    (value) => setState(
                                      () => selectedChips = category,
                                    ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                SfCartesianChart(
                  margin: EdgeInsets.symmetric(vertical: defaultPadding * 2),
                  borderWidth: 0,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(isVisible: false),
                  primaryYAxis: NumericAxis(
                    isVisible: false,
                    minimum: 0,
                    maximum: 2,
                    interval: 0.5,
                  ),
                  series: <CartesianSeries<ChartColumnData, String>>[
                    ColumnSeries<ChartColumnData, String>(
                      dataSource: chartData,
                      width: 0.8,
                      color: Color(0xFFFFC300),
                      xValueMapper: (ChartColumnData data, _) => data.x,
                      yValueMapper: (ChartColumnData data, _) => data.y1,
                    ),
                    ColumnSeries<ChartColumnData, String>(
                      dataSource: chartData,
                      color: Color(0xFF560BAD),
                      xValueMapper: (ChartColumnData data, _) => data.x,
                      yValueMapper: (ChartColumnData data, _) => data.y2,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 27,
                      height: 13,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFC300),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Apple',
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
                        color: Color(0xFF560BAD),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Orange',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: defaultPadding),
                Text(
                  'Minim dolorem ipsum dolor sit amet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: defaultPadding * 2),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF9F3FF),
                    border: Border.all(width: 3, color: Color(0xFF560BAD)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Icon(Icons.approval, color: Color(0xFF560BAD)),
                  ),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jerome Bell',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                Icon(Icons.message_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartColumnData {
  ChartColumnData(this.x, this.y1, this.y2);
  final String x;
  final double y1;
  final double y2;
}

final List<ChartColumnData> chartData = <ChartColumnData>[
  ChartColumnData("Mo", 1.7, 1.7),
  ChartColumnData("Tu", 1.3, 1.3),
  ChartColumnData("We", 1, 1),
  ChartColumnData("Th", 1.5, 1.5),
  ChartColumnData("Fr", 0.5, 1.3),
  ChartColumnData("Sa", 0.7, 1.8),
  ChartColumnData("Su", 0.6, 0.9),
];
