import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants.dart';
import 'chart_spline_area.dart';

class Row2 extends StatelessWidget {
  const Row2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
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
                      'Activity',
                      style: TextStyle(
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
                        color: Color(0xFF54AFBC),
                      ),
                    ),
                    SizedBox(width: defaultPadding / 2),
                    Text(
                      'Run',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: defaultPadding),
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
                      'Walk',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: defaultPadding * 2),
                SizedBox(height: 200, child: ChartSplineArea()),
                SizedBox(width: defaultPadding),
                Expanded(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: defaultPadding),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
              bottom: defaultPadding,
            ),
            height: 300,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Expanded(
                  child: TableCalendar(
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      formatButtonShowsNext: false,
                      titleTextStyle: TextStyle(color: Colors.white),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                    ),
                    weekendDays: [DateTime.saturday],
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.white),
                      rangeStartTextStyle: TextStyle(color: Colors.black),
                      withinRangeTextStyle: TextStyle(color: Colors.white),
                      outsideTextStyle: TextStyle(color: Colors.grey),
                      selectedDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 20, 165, 165),
                        shape: BoxShape.circle,
                      ),
                      rangeStartDecoration: BoxDecoration(color: Colors.white),
                      todayDecoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      holidayTextStyle: TextStyle(color: Colors.white),
                      holidayDecoration: BoxDecoration(
                        color: Color(0xFF9644FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: Color.fromARGB(122, 255, 255, 255),
                      ),
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    rowHeight: 35,
                    weekNumbersVisible: false,
                    locale: 'en_US',
                    selectedDayPredicate: (day) {
                      return isSameDay(DateTime.utc(2024, 11, 6), day);
                    },
                    holidayPredicate: (day) {
                      return isSameDay(DateTime.utc(2024, 11, 20), day);
                    },
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(210, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    // SizedBox(width: defaultPadding/2,),
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
                    // SizedBox(width: defaultPadding/2,),
                    Text(
                      'Cardio',
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
                        color: Color(0xFF54AFBC),
                      ),
                    ),
                    // SizedBox(width: defaultPadding/2,),
                    Text(
                      'Yoga',
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                      'Workout',
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
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.arrow_drop_down, color: Colors.white54),
                  ],
                ),
                ProgressBar(title1: 'Squats', percentage: 0.5, number: '50'),
                // SizedBox(height: defaultPadding/2,),
                ProgressBar(title1: 'Lunges', percentage: 0.9, number: '90'),
                // SizedBox(height: defaultPadding/2,),
                ProgressBar(title1: 'Push-ups', percentage: 0.15, number: '15'),
                // // SizedBox(height: defaultPadding/2,),
                ProgressBar(
                  title1: 'Stretching',
                  percentage: 0.7,
                  number: '70',
                ),
                //  ProgressBar(
                //   title1: 'Skipping rope',
                //   percentage: 0.3,
                //   number: '30',
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.title1,
    required this.number,
    required this.percentage,
  });
  final String title1, number;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: defaultPadding * 2),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: number,
                  style: TextStyle(color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                      text: "/100",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: GFProgressBar(
            margin: EdgeInsets.all(0),
            percentage: percentage,
            backgroundColor: bgColor,
            linearGradient: LinearGradient(
              colors: [Color(0xFF5747EF), Color(0xFF58D9D9)],
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ],
    );
  }
}
