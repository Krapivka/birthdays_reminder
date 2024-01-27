import 'package:birthdays_reminder/core/data/datasources/person_local_data_source.dart';
import 'package:birthdays_reminder/core/data/repositories/person_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'birthdays_reminder_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final personApi = PersonLocalDataSourceImpl(
      sharedPreferences: await SharedPreferences.getInstance());

  final personRepository = PersonRepositoryImpl(localDataSource: personApi);

  runApp(App(personRepository: personRepository));
}
