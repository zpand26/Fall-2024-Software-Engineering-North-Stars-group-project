// views/calendar_view.dart
import 'package:flutter/material.dart';
import 'package:north_stars/models/data_entry_for_day_model.dart';
import 'package:table_calendar/table_calendar.dart';
import '../presenters/nutrition_goal_presenter.dart';
import '../models/calorie_tracker_model.dart';
import 'package:north_stars/views/data_entry_for_day_view.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';

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
  final NutritionGoalPresenter _nutritionGoalPresenter = NutritionGoalPresenter();
  final CalorieTrackerModel _calorieTracker = CalorieTrackerModel();
  final DataEntryForDayModel _dataEntryForDayModel = DataEntryForDayModel();

  @override
  void initState() {
    super.initState();
    _fetchDataForDay(_selectedDay);
  }

  Future<void> _fetchDataForDay(DateTime day) async {
    try {
      // Clear current events for the selected day
      _events[day] = [];

      // Fetch data for the selected day
      final year = day.year;
      final month = day.month;
      final dayOfMonth = day.day;

      final calories = await _calorieTracker.getTotalCaloriesOnDay(year, month, dayOfMonth);
      final fat = await _calorieTracker.getTotalFatOnDay(year, month, dayOfMonth);
      final cholesterol = await _calorieTracker.getTotalCholesterolOnDay(year, month, dayOfMonth);
      final sodium = await _calorieTracker.getTotalSodiumOnDay(year, month, dayOfMonth);
      final carbs = await _calorieTracker.getTotalCarbsOnDay(year, month, dayOfMonth);
      final fiber = await _calorieTracker.getTotalFiberOnDay(year, month, dayOfMonth);
      final sugar = await _calorieTracker.getTotalSugarOnDay(year, month, dayOfMonth);
      final protein = await _calorieTracker.getTotalProteinOnDay(year, month, dayOfMonth);

      // Check if all values are 0 or missing
      if (calories == 0 && fat == 0 && cholesterol == 0 && sodium == 0 &&
          carbs == 0 && fiber == 0 && sugar == 0 && protein == 0) {
        return; // No data for this day, do not add an event
      }

      // Combine all data into a single string
      final event = '''
    Calories: $calories
    Total Fat: $fat
    Cholesterol: $cholesterol
    Sodium: $sodium
    Total Carbohydrate: $carbs
    Fiber: $fiber
    Total Sugar: $sugar
    Protein: $protein
    ''';

      // Add the single event for this day
      setState(() {
        _events[day] = [event];
      });
    } catch (e) {
      print('Error fetching data for day: $e');
    }
  }



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
                  onDaySelected: (selectedDay, focusedDay) async {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });

                    await _fetchDataForDay(selectedDay);
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
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Daily Intake Button
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3 - 24,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3 - 24,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DayEntryView(DataEntryForDayPresenter(
                            _dataEntryForDayModel, (data) => print(data))))
                      );
                    },
                    icon: const Icon(Icons.calendar_view_week, color: Colors.white),
                    label: Text(
                      'Weekly Data Entry',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Add Data Button
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3 - 24,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onPressed: _showAddEventDialog,
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Add Data'),
                  ),
                ),
              ],
            ),
          )
        ],
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
      floatingActionButton: null,
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
  void _showIntakeSummary() async {
    final calories = await _calorieTracker.getTotalCaloriesOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final fat = await _calorieTracker.getTotalFatOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final cholesterol = await _calorieTracker.getTotalCholesterolOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final sodium = await _calorieTracker.getTotalSodiumOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final carbs = await _calorieTracker.getTotalCarbsOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final fiber = await _calorieTracker.getTotalFiberOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final sugar = await _calorieTracker.getTotalSugarOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final protein = await _calorieTracker.getTotalProteinOnDay(_selectedDay.year, _selectedDay.month, _selectedDay.day);

    final nutritionData = ''' 
      Calories: $calories
      Fat: $fat
      Cholesterol: $cholesterol
      Sodium: $sodium
      Carbohydrates: $carbs
      Fiber: $fiber
      Sugar: $sugar
      Protein: $protein
    ''';
    final assessment = _nutritionGoalPresenter.evaluateIntake(nutritionData);

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
              const SizedBox(height: 16),
              Text(
                assessment,
                style: TextStyle(
                  color: assessment == 'Bulking'
                      ? Colors.green
                      : assessment == 'Cutting'
                      ? Colors.blue
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
