import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/calorie_tracker_model.dart';
import '../models/data_entry_for_day_model.dart';
import '../presenters/nutrition_goal_presenter.dart';
import '../views/data_entry_for_day_view.dart';
import '../presenters/data_entry_for_day_presenter.dart';

class NutritionGoalView extends StatefulWidget {
  const NutritionGoalView({Key? key}) : super(key: key);

  @override
  _NutritionGoalViewState createState() => _NutritionGoalViewState();
}

class _NutritionGoalViewState extends State<NutritionGoalView> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final Map<DateTime, List<String>> _events = {};
  final CalorieTrackerModel _calorieTracker = CalorieTrackerModel();
  final NutritionGoalPresenter _nutritionGoalPresenter = NutritionGoalPresenter();
  final DataEntryForDayModel _dataEntryForDayModel = DataEntryForDayModel();

  @override
  void initState() {
    super.initState();
    _fetchDataForDay(_selectedDay);
  }

  Future<void> _fetchDataForDay(DateTime day) async {
    try {

      _events[day] = [];
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

      if (calories == 0 && fat == 0 && cholesterol == 0 && sodium == 0 &&
          carbs == 0 && fiber == 0 && sugar == 0 && protein == 0) {
        return; // No data for this day, do not add an event
      }

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

      setState(() {
        _events[day] = [event];
      });
    } catch (e) {
      print('Error fetching data: $e');
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
      ),
      floatingActionButton: null,
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
      'Fat',
      'Cholesterol',
      'Sodium',
      'Carbohydrates',
      'Fiber',
      'Total Sugar',
      'Protein',
      'Caffeine',
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Nutrition Data'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(9, (index) {
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
                    await _calorieTracker.addCaffeine(
                        int.tryParse(controllers[8].text) ?? 0,year,month, day);

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

  void clearEvents(){
    setState(() {
      _events.clear();
    });
  }
}
