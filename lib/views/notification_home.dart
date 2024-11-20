import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../presenters/notification_presenter.dart';

class NotificationHome extends StatefulWidget {
  @override
  _NotificationHomeState createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  late NotificationPresenter _presenter;
  late NotificationModel _model;
  bool _areNotificationsEnabled = true;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _model = NotificationModel();
    _presenter = NotificationPresenter(_model, (bool areEnabled) {
      setState(() {
        _areNotificationsEnabled = areEnabled;
      });
    });

    // Correctly load the initial settings
    _presenter.loadInitialSettings();
  }

  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

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
      appBar: AppBar(
        title: const Text('Meal Reminders'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _areNotificationsEnabled,
              onChanged: (bool value) {
                _presenter.toggleNotifications(value);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _areNotificationsEnabled
                  ? () {
                _presenter.showInstantNotification(
                  "Meal Reminder",
                  "It's time for your meal!",
                );
              }
                  : null, // Disable button if notifications are off
              child: const Text('Show Instant Meal Reminder'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _areNotificationsEnabled ? _pickDateTime : null, // Disable button if notifications are off
              child: const Text('Pick Meal Reminder Time'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _areNotificationsEnabled
                  ? () {
                if (_selectedDateTime != null) {
                  _presenter.scheduleNotification(
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
              }
                  : null, // Disable button if notifications are off
              child: const Text('Schedule Meal Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
