import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/calendar_model.dart';

class CalendarPresenter {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<DateTime, List<String>>> loadEvents() async {
    final snapshots = await _firestore.collection('events').get();
    final Map<DateTime, List<String>> events = {};
    for (var doc in snapshots.docs) {
      final event = EventModel.fromMap(doc.data());
      events[event.date] = event.events;
    }
    return events;
  }

  Future<void> saveEvent(EventModel event) async {
    await _firestore.collection('events').doc(event.date.toIso8601String()).set(event.toMap());
  }

  String evaluateIntake(String event) {
    // Your evaluation logic here
    return "Example evaluation";
  }
}
