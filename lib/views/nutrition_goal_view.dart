// views/calendar_view.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../presenters/nutrition_goal_presenter.dart';

class NutritionGoalView extends StatefulWidget {
  const NutritionGoalView({super.key});

  @override
  _NutritionGoalViewState createState() => _NutritionGoalViewState();
}

class _NutritionGoalViewState extends State<NutritionGoalView> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final Map<DateTime, List<String>> _events = {};
  final NutritionGoalPresenter _presenter = NutritionGoalPresenter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Goal Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.summarize),
            onPressed: _showIntakeSummary,
          ),
        ],
      ),
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
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
          ..._getEventsForDay(_selectedDay).map((event) => ListTile(
                title: Text(event),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _showIntakeSummary() {
    final events = _getEventsForDay(_selectedDay);
    final latestEvent = events.isNotEmpty ? events.last : null;
    final assessment = latestEvent != null ? 
      _presenter.evaluateIntake(latestEvent) 
      : 'No events logged for this day.';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Daily Intake Summary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (latestEvent == null)
                const Text('No events logged for this day.')
              else
                ...events.map((event) => Text(event)).toList(),
              const SizedBox(height: 16),
              Text(
                assessment,
                style: TextStyle(
                  color: assessment.contains('bulking') ? Colors.green
                   : assessment.contains('cutting') ? Colors.blue
                   : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showAddEventDialog() {
    final controllers = List.generate(8, (_) => TextEditingController());
    final labels = [
      'Calories', 'Total Fat', 'Cholesterol', 'Sodium',
      'Total Carbohydrate', 'Fiber', 'Total Sugar', 'Protein'
    ];
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Nutrition Data'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(8, (index) {
                return TextField(
                  controller: controllers[index],
                  decoration: InputDecoration(hintText: labels[index]),
                  keyboardType: TextInputType.number,
                );
              }),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controllers.any((controller) => controller.text.isNotEmpty)) {
                  final event = labels.asMap().entries.map((entry) {
                    return '${entry.value}: ${controllers[entry.key].text}';
                  }).join('\n');
                  _addEvent(event);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addEvent(String event) {
    setState(() {
      if (_events[_selectedDay] != null) {
        _events[_selectedDay]!.add(event);
      } else {
        _events[_selectedDay] = [event];
      }
    });
  }
}
