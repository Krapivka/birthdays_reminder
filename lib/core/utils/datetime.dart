class DateTimeUtils {
  String formatDate(DateTime dateTime) =>
      dateTime.toIso8601String().split('T').first;
}
