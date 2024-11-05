import 'package:flutter/material.dart';
import 'package:north_stars/notification/notification.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? _selectedDateTime;

  Future<void> _pickDateTime() async {
    // Pick a date
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    // Pick a time
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    // Combine date and time into a single DateTime
    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal Reminder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                NotificationService.showInstantNotification(
                  "Meal Reminder",
                  "It's time for your meal!",
                );
              },
              child: const Text('Show Instant Meal Reminder'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickDateTime,
              child: const Text('Pick Meal Reminder Time'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedDateTime != null) {
                  NotificationService.scheduleNotification(
                    0,
                    "Scheduled Meal Reminder",
                    "It's time for your meal!",
                    _selectedDateTime!,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Meal reminder scheduled for $_selectedDateTime')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please pick a date and time first')),
                  );
                }
              },
              child: const Text('Schedule Meal Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
