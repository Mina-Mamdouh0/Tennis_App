import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../set_reminder/model/evenet_data.dart';

class AppointmentDataSource extends CalendarDataSource {
  List<EventModel> events;

  AppointmentDataSource(this.events);

  @override
  List<dynamic> get appointments => events;

  @override
  DateTime getStartTime(int index) => events[index].startTime;

  @override
  DateTime getEndTime(int index) => events[index].endTime;

  @override
  String getSubject(int index) => events[index].subject;

  @override
  Color getColor(int index) => events[index].color;
}
