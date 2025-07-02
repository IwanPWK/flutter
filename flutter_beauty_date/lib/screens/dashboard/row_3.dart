import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';
import 'package:flutter_beauty_date/models/data.dart';
import 'package:flutter_beauty_date/screens/dashboard/chart_ring.dart';
import 'package:flutter_beauty_date/screens/dashboard/row_2.dart';
import 'package:google_fonts/google_fonts.dart';

class Row3 extends StatelessWidget {
  const Row3({
    super.key,
    required ScrollController scrollController,
    required ScrollController scrollControllerUncoming,
  }) : _scrollController = scrollController,
       _scrollControllerUncoming = scrollControllerUncoming;

  final ScrollController _scrollController;
  final ScrollController _scrollControllerUncoming;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            height: 250,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Text(
                        'Medications',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          'Week',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white54,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.white54),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(flex: 2, child: ChartRing()),
                    // Spacer(),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 150,
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: ContainerBar(
                                    title: 'Cough',
                                    value: '24,9%',
                                    percentage: 0.25,
                                    color: secondaryColor,
                                  ),
                                ),

                                SizedBox(height: 5),

                                SizedBox(
                                  width: 130,
                                  child: ContainerBar(
                                    title: 'Fever',
                                    value: '11%',
                                    percentage: 0.11,
                                    color: Color(0xFF4FF0B4),
                                  ),
                                ),
                                SizedBox(height: 5),

                                SizedBox(
                                  width: 130,
                                  child: ContainerBar(
                                    title: 'Common',
                                    value: '20.2%',
                                    percentage: 0.20,
                                    color: secondaryColor2,
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: 130,
                                  child: ContainerBar(
                                    title: 'Head',
                                    value: '12%',
                                    percentage: 0.12,
                                    color: Color(0xFFF9A266),
                                  ),
                                ),
                                SizedBox(height: 5),

                                SizedBox(
                                  width: 130,
                                  child: ContainerBar(
                                    title: 'Common',
                                    value: '20.2%',
                                    percentage: 0.20,
                                    color: secondaryColor2,
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: 130,
                                  child: ContainerBar(
                                    title: 'Head',
                                    value: '12%',
                                    percentage: 0.12,
                                    color: Color(0xFFF9A266),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: defaultPadding * 2),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            height: 250,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Uncoming dates for reservation',
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        'June',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white54,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white54),
                  ],
                ),
                SizedBox(height: defaultPadding),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollControllerUncoming,
                    child: SingleChildScrollView(
                      controller: _scrollControllerUncoming,
                      child: DataTable(
                        headingTextStyle: TextStyle(color: Colors.white54),
                        headingRowHeight: 25,
                        horizontalMargin: 0,
                        dataRowHeight: 35,
                        columnSpacing: 0,
                        columns: [
                          DataColumn(label: Text('Services')),
                          DataColumn(label: Text('15')),
                          DataColumn(label: Text('16')),
                          DataColumn(label: Text('17')),
                          DataColumn(label: Text('18')),
                          DataColumn(label: Text('19')),
                          DataColumn(label: Text('20')),
                          DataColumn(label: Text('21')),
                          DataColumn(label: Text('22')),
                          DataColumn(label: Text('23')),
                          DataColumn(label: Text('24')),
                          DataColumn(label: Text('25')),
                          DataColumn(label: Text('26')),
                        ],
                        rows: List.generate(
                          demoData.length,
                          (index) => _dataRow(demoData[index]),
                        ),
                      ),
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

DataRow _dataRow(Data data) {
  return DataRow(
    cells: [
      DataCell(Text(data.title, style: TextStyle(fontSize: 11))),
      DataCell(data.icon1),
      DataCell(data.icon2),
      DataCell(data.icon3),
      DataCell(data.icon4),
      DataCell(data.icon5),
      DataCell(data.icon6),
      DataCell(data.icon7),
      DataCell(data.icon8),
      DataCell(data.icon9),
      DataCell(data.icon10),
      DataCell(data.icon11),
      DataCell(data.icon12),
    ],
  );
}
