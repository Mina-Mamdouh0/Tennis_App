import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../set_reminder/model/evenet_data.dart';
import 'appointment_data_source.dart';

class DailyCalendar extends StatelessWidget {
  final List<EventModel> events;

  DailyCalendar(this.events);

  @override
  Widget build(BuildContext context) {
    final dataSource = AppointmentDataSource(events);
    return SfCalendar(
      dataSource: dataSource,
      view: CalendarView.day,
      showDatePickerButton: true,
      allowDragAndDrop: true,
      scheduleViewSettings: const ScheduleViewSettings(
        appointmentItemHeight: 70,
      ),
      timeSlotViewSettings: const TimeSlotViewSettings(
        numberOfDaysInView: 1,
        timeTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
