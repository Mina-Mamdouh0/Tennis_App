import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/chats.dart';

class MyReply extends StatelessWidget {
  const MyReply({Key? key, required this.message}) : super(key: key);

  final ChatMessage message;

  // Function to check if the messages are within the same hour
  bool isWithinSameHour(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day &&
        dateTime1.hour == dateTime2.hour;
  }

  // Function to check if the messages are within the same day
  bool isWithinSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  // Function to format the timestamp to display the minutes left or "Now"
  String formatMinutesLeft(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final minutes = difference.inMinutes;

    if (minutes < 1) {
      return 'Now';
    } else {
      return '$minutes minutes ago';
    }
  }

  // Function to format the timestamp to display the time with AM or PM
  String formatTimeOnly(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  // Function to format the timestamp to display date and time
  String formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yy hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDateTime = isWithinSameHour(now, message.timestamp.toDate())
        ? formatMinutesLeft(message.timestamp.toDate())
        : isWithinSameDay(now, message.timestamp.toDate())
            ? formatTimeOnly(message.timestamp.toDate())
            : formatDateTime(message.timestamp.toDate());

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(15),
          width: 250,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 193, 191, 191).withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
            color: const Color(0x33EE746C),
            border: Border.all(
              width: 0.25,
              color: const Color(0x5BC7C7C7),
            ),
          ),
          child: Column(
            children: [
              Text(
                message.content,
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  formattedDateTime, // Display the formatted date and time
                  style: TextStyle(
                    color: Color(0xFF707070),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
