import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;

  Event(this.title);
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTimeRange? _selectedDateRange;
  Map<DateTime, List<Event>> _events = {};
  final TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _events = {
      DateTime.now().subtract(const Duration(days: 2)): [Event('Event A')],
      DateTime.now(): [Event('Event B'), Event('Event C')],
      DateTime.now().add(const Duration(days: 3)): [Event('Event D')],
    };
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _addEvent() {
    if (_eventController.text.isEmpty) return;

    setState(() {
      if (_selectedDateRange != null) {
        for (var day in _getDaysInBetween(
          _selectedDateRange!.start,
          _selectedDateRange!.end,
        )) {
          final newEvent = Event(_eventController.text);
          final events = _events[DateTime(day.year, day.month, day.day)] ?? [];
          events.add(newEvent);
          _events[DateTime(day.year, day.month, day.day)] = events;
        }
      } else if (_selectedDay != null) {
        final newEvent = Event(_eventController.text);
        final events =
            _events[DateTime(
              _selectedDay!.year,
              _selectedDay!.month,
              _selectedDay!.day,
            )] ??
            [];
        events.add(newEvent);
        _events[DateTime(
              _selectedDay!.year,
              _selectedDay!.month,
              _selectedDay!.day,
            )] =
            events;
      }
      _eventController.clear();
      _selectedDateRange = null;
    });
    Navigator.of(context).pop();
  }

  List<DateTime> _getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Calendar')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            rangeStartDay: _selectedDateRange?.start,
            rangeEndDay: _selectedDateRange?.end,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedDateRange = null;
              });
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _selectedDay = null;
                _focusedDay = focusedDay;
                _selectedDateRange = DateTimeRange(start: start!, end: end!);
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _getEventsForDay(_selectedDay ?? _focusedDay).length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text(
                      _getEventsForDay(
                        _selectedDay ?? _focusedDay,
                      )[index].title,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Event'),
                content: TextField(controller: _eventController),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(onPressed: _addEvent, child: const Text('Add')),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
