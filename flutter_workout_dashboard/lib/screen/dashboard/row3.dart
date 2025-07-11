import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constants.dart';
import '../../models/meal_data.dart';
import 'chart_column.dart';

class Row3 extends StatelessWidget {
  const Row3({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 300,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Calories burnt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Quarter',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.arrow_drop_down, color: Colors.white54),
                  ],
                ),
                SizedBox(height: defaultPadding * 2),
                Expanded(child: ChartColumn()),
                SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: defaultPadding / 2),
                    Text(
                      'Fitness',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: defaultPadding * 1.5),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF9644FF),
                      ),
                    ),
                    SizedBox(width: defaultPadding / 2),
                    Text(
                      'Cardio',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: defaultPadding),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 300,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Water balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.arrow_drop_down, color: Colors.white54),
                  ],
                ),
                SizedBox(height: defaultPadding * 2),
                SizedBox(
                  child: CircularPercentIndicator(
                    radius: 80,
                    lineWidth: 18,
                    percent: 0.45,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: bgColor,
                    linearGradient: LinearGradient(
                      colors: [
                        Color(0xFF526ADA),
                        Color(0xFF526ADA),
                        Color(0xFF78E5E7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    center: Text(
                      '45%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: defaultPadding * 2),
                RichText(
                  text: TextSpan(
                    text: '1250 ',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                        text: "/ 2200 ml",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: defaultPadding),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 300,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Your meal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.arrow_drop_down, color: Colors.white54),
                  ],
                ),
                SizedBox(height: defaultPadding),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: DataTable(
                    headingRowHeight: 0,
                    horizontalMargin: 0,
                    dividerThickness: 0.4,
                    dataTextStyle: TextStyle(color: Colors.white),
                    columns: [
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                    ],
                    rows: List.generate(
                      demoMealData.length,
                      (index) => mealDataRow(demoMealData[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

DataRow mealDataRow(MealData mealData) {
  return DataRow(
    cells: [
      DataCell(Text(mealData.title1)),
      DataCell(Text(mealData.title2)),
      DataCell(
        Text(
          mealData.title3,
          style: TextStyle(color: Color.fromARGB(255, 179, 16, 238)),
        ),
      ),
      DataCell(
        Text(
          mealData.title4,
          style: TextStyle(color: Color.fromARGB(255, 149, 88, 253)),
        ),
      ),
    ],
  );
}
