import 'package:flutter/material.dart';

class EventModel {
  final DateTime startTime;
  final DateTime endTime;
  final String subject;
  final Color color;

  EventModel({
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.color,
  });

  // Convert EventModel to a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'subject': subject,
      'color': color.value,
    };
  }
}
