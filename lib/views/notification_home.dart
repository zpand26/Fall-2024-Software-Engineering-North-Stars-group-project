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

    // Load the initial settings
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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications Switch
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  _areNotificationsEnabled ? Icons.notifications_active : Icons.notifications_off,
                  color: _areNotificationsEnabled ? Colors.green : Colors.red,
                  size: 32,
                ),
                title: const Text(
                  'Enable Notifications',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Switch(
                  value: _areNotificationsEnabled,
                  onChanged: (bool value) {
                    _presenter.toggleNotifications(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Instant Notification Button
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Colors.blue, size: 32),
                title: const Text(
                  'Show Instant Meal Reminder',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: _areNotificationsEnabled
                    ? () {
                  _presenter.showInstantNotification(
                    "Meal Reminder",
                    "It's time for your meal!",
                  );
                }
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // Pick Reminder Time
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.schedule, color: Colors.orange, size: 32),
                title: const Text(
                  'Pick Meal Reminder Time',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: _selectedDateTime != null
                    ? Text(
                  'Selected: ${_selectedDateTime.toString().substring(0, 16)}',
                  style: const TextStyle(color: Colors.grey),
                )
                    : const Text('No time selected', style: TextStyle(color: Colors.grey)),
                onTap: _areNotificationsEnabled ? _pickDateTime : null,
              ),
            ),
            const SizedBox(height: 20),

            // Schedule Reminder Button
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle),
              label: const Text('Schedule Meal Reminder'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
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
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
