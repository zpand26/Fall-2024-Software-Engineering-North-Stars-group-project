import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../presenters/nutrition_goal_presenter.dart';
import '../models/calorie_tracker_model.dart';

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
  final CalorieTrackerModel _calorieTracker = CalorieTrackerModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Goal Tracker'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Calendar Section
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
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
                const SizedBox(height: 16),
                // Events Section
                Expanded(
                  child: _events[_selectedDay]?.isEmpty ?? true
                      ? const Center(
                    child: Text(
                      'No events logged for this day.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                      : ListView.builder(
                    itemCount: _events[_selectedDay]?.length ?? 0,
                    itemBuilder: (context, index) {
                      final event = _events[_selectedDay]![index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const Icon(Icons.event, color: Colors.teal),
                          title: Text(event),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Positioned Daily Intake Summary Button
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: _showIntakeSummary,
              icon: const Icon(Icons.summarize, color: Colors.white),
              label: Text(
                'Daily Intake',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddEventDialog,
        icon: const Icon(Icons.add),
        label: const Text('Add Data'),
        backgroundColor: Colors.teal,
      ),
    );
  }

  void _showIntakeSummary() async {
    final calories = await _calorieTracker.getTotalCaloriesOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final fat = await _calorieTracker.getTotalFatOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final cholesterol = await _calorieTracker.getTotalCholesterolOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final sodium = await _calorieTracker.getTotalSodiumOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final carbs = await _calorieTracker.getTotalCarbsOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final fiber = await _calorieTracker.getTotalFiberOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final sugar = await _calorieTracker.getTotalSugarOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final protein = await _calorieTracker.getTotalProteinOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    print(_selectedDay.year);
    print(_selectedDay.month);
    print(_selectedDay.day);
    final printCalories = await _calorieTracker.getTotalCaloriesOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    print('Calories: $printCalories');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Daily Intake Summary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Calories: $calories'),
              Text('Total Fat: $fat'),
              Text('Cholesterol: $cholesterol'),
              Text('Sodium: $sodium'),
              Text('Total Carbohydrate: $carbs'),
              Text('Fiber: $fiber'),
              Text('Total Sugar: $sugar'),
              Text('Protein: $protein'),
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
      'Calories',
      'Total Fat',
      'Cholesterol',
      'Sodium',
      'Total Carbohydrate',
      'Fiber',
      'Total Sugar',
      'Protein'
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextField(
                    controller: controllers[index],
                    decoration: InputDecoration(
                      hintText: labels[index],
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
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
              onPressed: () async {
                try {
                  if (controllers.any((controller) => controller.text.isNotEmpty)) {
                    final int year = _selectedDay.year;
                    final int month = _selectedDay.month;
                    final int day = _selectedDay.day;

                    await _calorieTracker.addCalories(
                        int.tryParse(controllers[0].text) ?? 0, year, month, day);
                    await _calorieTracker.addFat(
                        int.tryParse(controllers[1].text) ?? 0, year, month, day);
                    await _calorieTracker.addCholesterol(
                        int.tryParse(controllers[2].text) ?? 0, year, month, day);
                    await _calorieTracker.addSodium(
                        int.tryParse(controllers[3].text) ?? 0, year, month, day);
                    await _calorieTracker.addCarbs(
                        int.tryParse(controllers[4].text) ?? 0, year, month, day);
                    await _calorieTracker.addFiber(
                        int.tryParse(controllers[5].text) ?? 0, year, month, day);
                    await _calorieTracker.addSugar(
                        int.tryParse(controllers[6].text) ?? 0, year, month, day);
                    await _calorieTracker.addProtein(
                        int.tryParse(controllers[7].text) ?? 0, year, month, day);

                    final event = labels.asMap().entries.map((entry) {
                      return '${entry.value}: ${controllers[entry.key].text}';
                    }).join('\n');

                    _addEvent(event);
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  print('Error adding event: $e');
                  // Show error dialog or message if needed
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }


  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
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
