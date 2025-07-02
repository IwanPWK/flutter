import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';
import 'package:flutter_beauty_date/screens/dashboard/chart_column.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Row2 extends StatelessWidget {
  const Row2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            height: 225,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Consultation',
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: Text(
                        'This week',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(width: defaultPadding * 2),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: Text(
                        'Last week',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(width: defaultPadding * 2),
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
                SizedBox(height: defaultPadding),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(height: 150, child: ChartColumn()),
                    ),
                    SizedBox(width: defaultPadding * 2),
                    Column(
                      children: [
                        SizedBox(
                          child: CircularPercentIndicator(
                            radius: 60,
                            lineWidth: 15,
                            percent: 0.6,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: secondaryColor,
                            backgroundColor: bgColor,
                            center: Text(
                              '60%',
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: secondaryColor2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: defaultPadding / 2,
                              ),
                              child: Text(
                                'more than last week',
                                style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: defaultPadding * 2),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            height: 215,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Visits',
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
                SizedBox(height: defaultPadding),
                ContainerBar(
                  title: 'All receipt',
                  value: '530',
                  percentage: 0.7,
                  color: secondaryColor,
                ),
                SizedBox(height: defaultPadding / 2),
                ContainerBar(
                  title: 'Successfuly completed',
                  value: '478',
                  percentage: 0.6,
                  color: secondaryColor2,
                ),
                SizedBox(height: defaultPadding / 2),
                ContainerBar(
                  title: 'Receipt Canceled',
                  value: '52',
                  percentage: 0.3,
                  color: Color(0xFF01DFFF),
                ),
                SizedBox(height: defaultPadding / 2),
                ContainerBar(
                  title: 'New pasients',
                  value: '25',
                  percentage: 0.1,
                  color: Color(0xFFF9A266),
                ),
                // SizedBox(height: defaultPadding / 2),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContainerBar extends StatelessWidget {
  const ContainerBar({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.color,
  });

  final String title, value;
  final double percentage;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                Text(
                  value,
                  style: GoogleFonts.ubuntu(
                    color: Colors.white38,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 7,
              width: double.infinity,
              child: GFProgressBar(
                margin: EdgeInsets.only(left: 0),
                percentage: percentage,
                backgroundColor: bgColor,
                progressBarColor: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
