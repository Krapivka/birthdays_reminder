import 'package:birthdays_reminder/features/birthdays_list/widgets/birthday_card.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalendarView();
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({
    super.key,
  });

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TableCalendar(
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      locale: 'ru_RU',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
    ));
  }
}
