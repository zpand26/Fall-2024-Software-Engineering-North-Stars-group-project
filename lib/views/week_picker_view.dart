import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'week_picker_presenter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week Selector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeekSelector(),
    );
  }
}

class WeekSelector extends StatefulWidget {
  @override
  _WeekSelectorState createState() => _WeekSelectorState();
}

class _WeekSelectorState extends State<WeekSelector> {
  DateTime? selectedDate;
  List<DateTime> weekDays = [];

  late WeekPresenter _presenter;

  @override
  void initState() {
    super.initState();
    // Initialize the presenter and define callbacks for view updates
    _presenter = WeekPresenter(
      onDateSelected: (DateTime date) {
        setState(() {
          selectedDate = date;
        });
      },
      onWeekUpdated: (List<DateTime> week) {
        setState(() {
          weekDays = week;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Week'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedDate == null
                  ? 'Select a date'
                  : 'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _presenter.selectDate(context),
              child: Text('Pick a Date'),
            ),
            SizedBox(height: 20),
            if (weekDays.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Week from Sunday to Saturday:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: weekDays.map((day) {
                      return ChoiceChip(
                        label: Text(DateFormat('EEE, MM/dd').format(day)),
                        selected: false,
                        onSelected: (selected) {},
                      );
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
