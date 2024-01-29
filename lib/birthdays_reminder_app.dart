import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/adding_birthday/adding_birthday.dart';
import 'package:birthdays_reminder/features/home/home.dart';
import 'package:birthdays_reminder/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final PersonRepository personRepository;

  const App({super.key, required this.personRepository});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: personRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

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