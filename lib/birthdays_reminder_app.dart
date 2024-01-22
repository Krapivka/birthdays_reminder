import 'package:birthdays_reminder/features/adding_birthday/adding_birthday.dart';
import 'package:birthdays_reminder/features/home/home.dart';
import 'package:birthdays_reminder/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class BirthdaysReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Birthdays-reminder',
      theme: theme,
      routes: {
        '/': (context) => Home(),
        'add_birthday': (context) => AddingBirthdayPage(),
      },
    );
  }
}
