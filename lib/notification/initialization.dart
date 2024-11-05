import 'package:flutter/material.dart';
import 'package:north_stars/notification/notification.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();
}
