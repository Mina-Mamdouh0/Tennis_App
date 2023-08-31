import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../set_reminder/model/evenet_data.dart';
import 'appointment_data_source.dart';

class MonthlyCalendar extends StatelessWidget {
  final List<EventModel> events;

  MonthlyCalendar(this.events);

  @override
  Widget build(BuildContext context) {
    final dataSource = AppointmentDataSource(events);

    return SfCalendar(
      dataSource:
          dataSource, // dataSource: AppointmentDataSource(appointments),
      allowAppointmentResize: true, view: CalendarView.month,
      monthViewSettings: MonthViewSettings(showAgenda: true),
    );
  }
}
