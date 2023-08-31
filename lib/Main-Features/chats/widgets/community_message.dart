import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/chats.dart';
import '../../../models/player.dart';

class SenderMessage extends StatelessWidget {
  const SenderMessage({
    Key? key,
    required this.message,
    required this.player,
  }) : super(key: key);

  final ChatMessage message;
  final Player player;

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
      return '$minutes min';
    }
  }

  // Function to format the timestamp to display the time with AM or PM
  String formatTimeOnly(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  // Function to format the timestamp to display date and time
  String formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yy  hh:mm a').format(dateTime);
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
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: player.photoURL != ''
                ? NetworkImage(player.photoURL!) as ImageProvider
                : const AssetImage('assets/images/profile-event.jpg'),
            radius: 20,
          ),
          const SizedBox(
            width: 7,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(bottom: 14, right: 20, left: 20),
            width: 268,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.25, color: Color(0x5BC7C7C7)),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 6,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 5),
                  child: Text(
                    player.playerName,
                    style: const TextStyle(
                      color: Color(0xFF00344E),
                      fontFamily: 'Poppins',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    message.content, // Display the message content
                    style: const TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      formattedDateTime,
                      style: const TextStyle(
                        color: Color(0xFF707070),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
