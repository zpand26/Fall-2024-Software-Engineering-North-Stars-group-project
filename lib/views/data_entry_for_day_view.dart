import 'package:flutter/material.dart';
import 'package:day_picker/day_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:north_stars/presenters/data_entry_for_day_presenter.dart';
import '../presenters/calorie_tracker_presenter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DayEntryView extends StatefulWidget {
  final DataEntryForDayPresenter dataEntryForDayPresenter;

  const DayEntryView(this.dataEntryForDayPresenter, {super.key});

  @override
  _dayEntryViewState createState() => _dayEntryViewState();
}

final List<DayInWeek> _days = [
  DayInWeek("Mon", dayKey: "mon", isSelected: false),
  DayInWeek("Tue", dayKey: "tue", isSelected: false),
  DayInWeek("Wed", dayKey: "wed", isSelected: false),
  DayInWeek("Thu", dayKey: "thu", isSelected: false),
  DayInWeek("Fri", dayKey: "fri", isSelected: false),
  DayInWeek("Sat", dayKey: "sat", isSelected: false),
  DayInWeek("Sun", dayKey: "sun", isSelected: false),
];

List<String> listOfDays = [];

class _dayEntryViewState extends State<DayEntryView> {
  final TextEditingController _dayCalorieController = TextEditingController();
  final TextEditingController _dayFatController = TextEditingController();
  final TextEditingController _dayCholesterolController = TextEditingController();
  final TextEditingController _daySodiumController = TextEditingController();
  final TextEditingController _dayCarbsController = TextEditingController();
  final TextEditingController _dayFiberController = TextEditingController();
  final TextEditingController _daySugarController = TextEditingController();
  final TextEditingController _dayProteinController = TextEditingController();
  String _displayMessage = ''; //Stores message from presenter
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  /*DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedWeek = DateTime.now();
  final Map<DateTime, List<String>> _events = {};
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;*/
  final DateRangePickerController _rangePickerController = DateRangePickerController();

  @override
  void initState() {
    super.initState();
    //Initialize updateView callback
    widget.dataEntryForDayPresenter.updateView = (String message) {
      setState(() {
        _displayMessage = message;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    final customWidgetKey = GlobalKey<SelectWeekDaysState>();

    SelectWeekDays selectWeekDays = SelectWeekDays(
      key: customWidgetKey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      days: _days,
      border: false,
      width: MediaQuery
          .of(context)
          .size
          .width / 1.4,
      boxDecoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30.0),
      ),
      onSelect: (values) {
        print(values);
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Calories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                margin: const EdgeInsets.fromLTRB(50, 100, 50, 100),
                child: SfDateRangePicker(
                  controller: _rangePickerController,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: selectionChanged,
                  monthViewSettings: DateRangePickerMonthViewSettings(
                      enableSwipeSelection: false),
                ),
              ),
              TextField(
                controller: _dayCalorieController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Calories',
                ),
              ),
              TextField(
                controller: _dayFatController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Fats (g)',
                ),
              ),
              TextField(
                controller: _dayCholesterolController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Cholesterol (mg)',
                ),
              ),
              TextField(
                controller: _daySodiumController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Sodium (g)',
                ),
              ),
              TextField(
                controller: _dayCarbsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Carbs (g)',
                ),
              ),
              TextField(
                controller: _dayFiberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Fiber (g)',
                ),
              ),
              TextField(
                controller: _daySugarController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Sugars (g)',
                ),
              ),
              TextField(
                controller: _dayProteinController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Protein (g)',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  int calories = int.tryParse(_dayCalorieController.text) ?? 0;
                  int Fat = int.tryParse(_dayFatController.text) ?? 0;
                  int cholesterol = int.tryParse(_dayCholesterolController.text) ?? 0;
                  int sodium = int.tryParse(_daySodiumController.text) ?? 0;
                  int carbs = int.tryParse(_dayCarbsController.text) ?? 0;
                  int fiber = int.tryParse(_dayFiberController.text) ?? 0;
                  int sugar = int.tryParse(_daySugarController.text) ?? 0;
                  int protein = int.tryParse(_dayProteinController.text) ?? 0;
                  //Add all other data (like calories) here and add each as a parameter)
                  for (int i = 0; i < listOfDays.length; i++) {
                    widget.dataEntryForDayPresenter.addDailyCalorieEntry(
                        calories, Fat, cholesterol, sodium,
                        carbs, fiber, sugar, protein, listOfDays[i]);
                  }
                  _dayCalorieController.clear();
                  _dayFatController.clear();
                  _dayCholesterolController.clear();
                  _daySodiumController.clear();
                  _dayCarbsController.clear();
                  _dayFiberController.clear();
                  _daySugarController.clear();
                  _dayProteinController.clear();
                },
                child: const Text('Add Calorie Entry'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  widget.dataEntryForDayPresenter.showDailyCalories();
                },
                child: const Text('Show Calories per Day'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectWeekDays(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  days: _days,
                  boxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      // 10% of the width, so there are ten blinds.
                      colors: [
                        Color(0xFFE55CE4),
                        Color(0xFFBB75FB)
                      ], // whitish to gray
                      tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                    ),
                  ),
                  onSelect: (values) {
                    listOfDays = values;

                    print(values); //Tests value selector in terminal
                    print(listOfDays);
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Pop the current page (CalorieTrackerPage) off the stack and go back to the HomePage
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent),
                child: const Text('Back to Home'),
              ),
              SizedBox(height: 20.0),
              Text(
                _displayMessage,
                style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    int firstDayOfWeek = DateTime.sunday % 7;
    int endDayOfWeek = (firstDayOfWeek - 1) % 7;
    endDayOfWeek = endDayOfWeek < 0 ? 7 + endDayOfWeek : endDayOfWeek;
    PickerDateRange ranges = args.value;
    DateTime date1 = ranges.startDate!;
    DateTime date2 = (ranges.endDate ?? ranges.startDate)!;
    if (date1.isAfter(date2)) {
      var date = date1;
      date1 = date2;
      date2 = date;
    }
    int day1 = date1.weekday % 7;
    int day2 = date2.weekday % 7;

    DateTime dat1 = date1.add(Duration(days: (firstDayOfWeek - day1)));
    DateTime dat2 = date2.add(Duration(days: (endDayOfWeek - day2)));

    if (!DateUtils.isSameDay(dat1, ranges.startDate) ||
        !DateUtils.isSameDay(dat2, ranges.endDate)) {
      _rangePickerController.selectedRange = PickerDateRange(dat1, dat2);
    }
    widget.dataEntryForDayPresenter.selectDates(dat1, dat2);
  }
}
