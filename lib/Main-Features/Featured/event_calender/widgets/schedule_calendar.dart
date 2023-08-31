import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tennis_app/constants.dart';
import '../../set_reminder/model/evenet_data.dart';
import 'appointment_data_source.dart';

class ScheduleCalendar extends StatelessWidget {
  final List<EventModel> events;

  ScheduleCalendar(this.events);

  @override
  Widget build(BuildContext context) {
    final dataSource = AppointmentDataSource(events);

    return SfCalendar(
      view: CalendarView.schedule,
      dataSource: dataSource,
      scheduleViewSettings: const ScheduleViewSettings(
        weekHeaderSettings: WeekHeaderSettings(
          startDateFormat: 'dd MMM ',
          endDateFormat: 'dd MMM, yy',
          height: 50,
          textAlign: TextAlign.center,
          backgroundColor: Color(0x5400344E),
          weekTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        dayHeaderSettings: DayHeaderSettings(
          dayFormat: 'EEEE',
          width: 70,
          dayTextStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            color: Colors.red,
          ),
          dateTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.red,
          ),
        ),
        monthHeaderSettings: MonthHeaderSettings(
          monthFormat: 'MMMM, yyyy',
          height: 100,
          textAlign: TextAlign.left,
          backgroundColor: kPrimaryColor,
          monthTextStyle: TextStyle(
            color: Color(0xFF00344E),
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
