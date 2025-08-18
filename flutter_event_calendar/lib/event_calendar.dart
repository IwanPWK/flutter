import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'utils.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;

    loadPreviousEvents();
  }

  loadPreviousEvents() {
    mySelectedEvents = {
      "2025-08-13": [
        {"eventDescp": "11", "eventTitle": "111"},
        {"eventDescp": "22", "eventTitle": "22"},
      ],
      "2025-08-30": [
        {"eventDescp": "22", "eventTitle": "22"},
      ],
      "2025-08-20": [
        {"eventTitle": "ss", "eventDescp": "ss"},
      ],
    };
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Event', textAlign: TextAlign.center),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descpController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                child: const Text('Add Event'),
                onPressed: () {
                  if (titleController.text.isEmpty &&
                      descpController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Required title and description'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    print('rangeStart $_rangeStart');
                    print('rangeEnd $_rangeEnd');
                    // Jika single date
                    if (_selectedDate != null) {
                      final dateKey = DateFormat(
                        'yyyy-MM-dd',
                      ).format(_selectedDate!);
                      if (mySelectedEvents[dateKey] != null) {
                        mySelectedEvents[dateKey]?.add({
                          "eventTitle": titleController.text,
                          "eventDescp": descpController.text,
                        });
                      } else {
                        mySelectedEvents[dateKey] = [
                          {
                            "eventTitle": titleController.text,
                            "eventDescp": descpController.text,
                          },
                        ];
                      }
                    }
                    // Jika range date
                    else if (_rangeStart != null && _rangeEnd != null) {
                      DateTime current = _rangeStart!;
                      while (!current.isAfter(_rangeEnd!)) {
                        final dateKey = DateFormat(
                          'yyyy-MM-dd',
                        ).format(current);
                        if (mySelectedEvents[dateKey] != null) {
                          mySelectedEvents[dateKey]?.add({
                            "eventTitle": titleController.text,
                            "eventDescp": descpController.text,
                          });
                        } else {
                          mySelectedEvents[dateKey] = [
                            {
                              "eventTitle": titleController.text,
                              "eventDescp": descpController.text,
                            },
                          ];
                        }
                        current = current.add(const Duration(days: 1));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a date or range first'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }
                  });

                  print(
                    "New Event for backend developer ${json.encode(mySelectedEvents)}",
                  );
                  titleController.clear();
                  descpController.clear();
                  Navigator.pop(context);
                  return;
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Event Calendar Example'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: _rangeSelectionMode,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                  _rangeStart = null; // Important to clean those
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                });
              }
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _selectedDate = null;
                _focusedDay = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOn;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
            eventLoader: _listOfDayEvents,
          ),
          if (_selectedDate != null)
            ..._listOfDayEvents(_selectedDate!).map(
              (myEvents) => ListTile(
                leading: const Icon(Icons.done, color: Colors.teal),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Event Title:   ${myEvents['eventTitle']}'),
                ),
                subtitle: Text('Description:   ${myEvents['eventDescp']}'),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
      ),
    );
  }
}
