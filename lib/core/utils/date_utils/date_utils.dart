import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDate(DateTime dateTime, String dateFormat) {
    final DateFormat formatter = DateFormat(dateFormat);
    final date = formatter.format(dateTime);

    return date;
  }

  static int getDifferenceDate(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  static String getDifferenceCurrentDayBirthDay(DateTime birthday) {
    DateTime currentDate = DateTime.now();

    DateTime nextBirthday =
        DateTime(currentDate.year, birthday.month, birthday.day);

    if (currentDate.day == nextBirthday.day &&
        currentDate.month == nextBirthday.month) {
      return 0.toString();
    }
    if (currentDate.isAfter(nextBirthday)) {
      nextBirthday =
          DateTime(currentDate.year + 1, birthday.month, birthday.day);
    }

    int differenceInDays = nextBirthday.difference(currentDate).inDays;

    return (differenceInDays + 1).toString();
  }

  static String parseDateToString(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }
}
