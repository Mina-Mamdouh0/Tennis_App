import 'package:intl/intl.dart';

class GlobalMethod {
  String formatDateTimeString(String timeString) {
    try {
      DateTime dateTime = DateTime.parse(timeString);
      String formattedDateTime =
          DateFormat("dd MMMM yyyy, hh:mm a").format(dateTime);
      return formattedDateTime;
    } catch (e) {
      // Return the original time string if there is an error in parsing
      return timeString;
    }
  }
}
