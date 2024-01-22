import 'package:birthdays_reminder/features/birthdays_list/widgets/birthday_card.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalendarView();
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("CalendarPAge"),
    ));
  }
}
