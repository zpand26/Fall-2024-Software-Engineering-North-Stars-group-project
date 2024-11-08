import 'package:north_stars/models/notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsPresenter {
  Future<void> initializeNotifications() async {
    await NotificationService.init();
  }

  void showInstantNotification(String title, String body) {
    NotificationService.showInstantNotification(title, body);
  }

  Future<void> scheduleNotification(int id, String title, String body, DateTime scheduledTime) async {
    await NotificationService.scheduleNotification(id, title, body, scheduledTime);
  }

  Future<void> requestNotificationPermission() async {
    await NotificationService.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
}
