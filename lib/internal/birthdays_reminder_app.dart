import 'package:birthdays_reminder/internal/app.dart';
import 'package:birthdays_reminder/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class BirthdaysReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Birthdays-reminder',
      theme: theme,
      home: App(),
    );
  }
}
