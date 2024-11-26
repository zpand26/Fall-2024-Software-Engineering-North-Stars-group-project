import '../models/notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

typedef ViewUpdater = void Function(bool);

class NotificationPresenter {
  final NotificationModel _model;
  final ViewUpdater updateView;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationPresenter(this._model, this.updateView) {
    _initNotifications();
    _checkNotificationPermissions();
  }

  void toggleNotifications(bool isEnabled) {
    _model.areNotificationsEnabled = isEnabled;
    updateView(isEnabled);
    NotificationModel.saveNotificationState(isEnabled); // Save state persistently

    if (!isEnabled) {
      NotificationService.cancelAllNotifications(); // Cancel scheduled notifications when disabled
    }
  }

  // Public method to load initial settings
  Future<void> loadInitialSettings() async {
    await _loadInitialNotificationState();
  }

  Future<void> _loadInitialNotificationState() async {
    bool state = await NotificationModel.loadNotificationState();
    _model.areNotificationsEnabled = state;
    updateView(state);
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        print("Notification received: ${response.payload}");
      },
      onDidReceiveBackgroundNotificationResponse: (response) {
        print("Background notification received: ${response.payload}");
      },
    );
  }

  Future<void> _checkNotificationPermissions() async {
    final bool? granted = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();

    if (granted != true) {
      print("Notification permissions are not granted.");
    } else {
      print("Notification permissions are granted.");
    }
  }

  void showInstantNotification(String title, String body) {
    if (!_model.areNotificationsEnabled) return; // Check model state before showing
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'instant_notification_channel_id',
        'Instant Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'instant_notification',
    );
  }

  Future<void> scheduleNotification(int id, String title, String body, DateTime scheduledTime) async {
    if (!_model.areNotificationsEnabled) return; // Check model state before scheduling
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_channel_id',
          'Scheduled Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}