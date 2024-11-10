import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../presenters/notification_presenter.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  late NotificationPresenter _presenter;
  late NotificationModel _model;
  bool _areNotificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _model = NotificationModel();
    _presenter = NotificationPresenter(_model, (bool areEnabled) {
      setState(() {
        _areNotificationsEnabled = areEnabled;
      });
    });

    _presenter.loadInitialSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: Center(
        child: SwitchListTile(
          title: const Text('Enable Notifications'),
          value: _areNotificationsEnabled,
          onChanged: (bool value) {
            _presenter.toggleNotifications(value);
          },
        ),
      ),
    );
  }
}
