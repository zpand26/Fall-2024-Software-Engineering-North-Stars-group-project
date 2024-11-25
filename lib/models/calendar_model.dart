import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final DateTime date;
  final List<String> events;

  EventModel({required this.date, required this.events});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'events': events,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      date: (map['date'] as Timestamp).toDate(),
      events: List<String>.from(map['events']),
    );
  }
}
