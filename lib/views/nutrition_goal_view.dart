// views/calendar_view.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../presenters/nutrition_goal_presenter.dart';
import '../models/nutrition_goal_model.dart';

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
          if (_getEventsForDay(_selectedDay).isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Logged Nutrition Data:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ..._getEventsForDay(_selectedDay).map(
              (event) => ListTile(
                title: Text(event),
              ),
            ),
          ],
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Nutrition Goals',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _buildTargetTable(),
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

    if (events.isEmpty) {
      _showAlert('No events logged for this day.');
      return;
    }

    final latestEvent = events.last;
    final assessment = _presenter.evaluateIntake(latestEvent);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Daily Intake Summary'),
          content: Text(assessment),
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
    final controllers = List.generate(9, (_) => TextEditingController());
    final labels = [
      'Calories',
      'Total Fat (g)',
      'Cholesterol (mg)',
      'Sodium (mg)',
      'Total Carbohydrate (mg)',
      'Fiber (g)',
      'Total Sugar (g)',
      'Protein (g)',
      'Caffeine (mg)'
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Nutrition Data'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                labels.length,
                (index) => TextField(
                  controller: controllers[index],
                  decoration: InputDecoration(hintText: labels[index]),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final isValidInput = controllers
                    .any((controller) => controller.text.isNotEmpty);

                if (isValidInput) {
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

  Widget _buildTargetTable() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder.all(color: Colors.grey),
        columnWidths: const {
          0: FractionColumnWidth(0.5),
          1: FractionColumnWidth(0.25),
          2: FractionColumnWidth(0.25),
        },
        children: [
          const TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'Nutrient',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'Bulking',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'Cutting',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ...NutritionGoalModel.bulkingTarget.entries.map((entry) {
            final nutrient = entry.key;
            final bulkingValue = entry.value;
            final cuttingValue =
                NutritionGoalModel.cuttingTarget[nutrient] ?? 0;
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(nutrient),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(bulkingValue.toString(), textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(cuttingValue.toString(), textAlign: TextAlign.center),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Notice'),
          content: Text(message),
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
}
