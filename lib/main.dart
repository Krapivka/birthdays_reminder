import 'package:birthdays_reminder/core/data/datasources/person_local_data_source.dart';
import 'package:birthdays_reminder/core/data/repositories/person_repository_impl.dart';
import 'package:birthdays_reminder/core/data/services/notification_service.dart';
import 'package:birthdays_reminder/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:birthdays_reminder/features/settings/data/repository/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'birthdays_reminder_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotifications();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final personApi =
      PersonLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final settingsApi =
      SettingsLocalDataSource(sharedPreferences: sharedPreferences);
  final personRepository = PersonRepositoryImpl(localDataSource: personApi);
  final settingsRepository = SettingsRepository(localDataSource: settingsApi);
//ok
  runApp(App(
    personRepository: personRepository,
    settingsRepository: settingsRepository,
  ));
}
