import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/app_settings.dart';
import '../models/habit.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize the database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      HabitSchema,
      AppSettingsSchema,
    ], directory: dir.path);
  }

  // Save first date of app startup (for heatmap)
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // Get first date of app startup (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  // C R U D  Operations

  // List of habits
  final List<Habit> currentHabits = [];

  // add a new habit
  Future<void> addHabit(String habitName) async {
    // Create a new habit
    final newHabit = Habit()..name = habitName;
    // Add the habit to the database
    await isar.writeTxn(() => isar.habits.put(newHabit));
    // Read all habits from the database
    readHabits();
  }

  // READ-read saved habits from db
  Future<void> readHabits() async {
    // fetch all habits from the database
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // give to current habits

    // Update the list of habits
    currentHabits.clear();
    // Add the fetched habits to the list of habits
    currentHabits.addAll(fetchedHabits);
    // Notify listeners / update UI
    notifyListeners();
  }

  // Update check habit on and off
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    // Get the habit with the given id
    //find the specific habit
    final habit = await isar.habits.get(id);
    // If the habit exists
    // update completion status
    if (habit != null) {
      // Update the habit
      await isar.writeTxn(() async {
        // If the habit is completed and not already in the list of completed days
        // If habit is completed -> add the current date to the completed days list
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          // Add the current date to the list of completed days
          final today = DateTime.now();

          // add the current date if it's not already in the list
          habit.completedDays.add(DateTime(today.year, today.month, today.day));

          // if habit is NOT completed -> remove the current date from the list
        } else {
          // Remove the current date if the habit is marked as not completed
          habit.completedDays.removeWhere(
            (date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day,
          );
        }
        // Update the habit in the database
        // Save the updated habits back to the db
        await isar.habits.put(habit);
      });
      // re-read from db
      readHabits();
    }
  }

  // UPDATE - edit habit name
  Future<void> updateHabitName(int id, String newName) async {
    // Get the habit with the given id
    // find the specific habit
    final habit = await isar.habits.get(id);
    // If the habit exists
    // update the name of the habit
    if (habit != null) {
      // Update the habit
      await isar.writeTxn(() async {
        habit.name = newName;
        // Update the habit back to the db
        await isar.habits.put(habit);
      });

      // re-read from db
      readHabits();
    }
  }

  // DELETE - delete habit
  Future<void> deleteHabit(int id) async {
    // perform the delete
    await isar.writeTxn(() => isar.habits.delete(id));

    // re-read from db
    readHabits();
  }
}
