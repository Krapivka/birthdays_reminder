class DateTimeUtils {
  String formatDate(DateTime dateTime) =>
      dateTime.toIso8601String().split('T').first;

  int getDifferenceDate(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  String getDifferenceCurrentDayBirthDay(DateTime birthday) {
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
}
