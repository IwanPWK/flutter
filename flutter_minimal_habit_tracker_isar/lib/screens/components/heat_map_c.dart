import 'package:flutter/material.dart';
import 'package:flutter_minimal_habit_tracker_isar/database/habit.dart';
import 'package:flutter_minimal_habit_tracker_isar/models/habit.dart';

Widget buildHeatMap() {
  final habitDatabase = context.watch<HabitDatabase>();
  List<Habit> currentHabits = habitDatabase.currentHabits;
  return FutureBuilder<DateTime?>(
    future: habitDatabase.getFirstLaunchDate(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return MyHeatMap(
          startDate: snapshot.data!,
          datasets: prepareHeatMapData(currentHabits),
        );
      } else {
        return Container();
      }
    },
  );
}
