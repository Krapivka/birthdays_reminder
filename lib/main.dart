import 'package:birthdays_reminder/core/data/datasources/person_local_data_source.dart';
import 'package:birthdays_reminder/core/data/repositories/person_repository_impl.dart';
import 'package:birthdays_reminder/core/services/notification/notification_service.dart';
import 'package:birthdays_reminder/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:birthdays_reminder/features/settings/data/repository/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import 'birthdays_reminder_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;
  MobileAds.initialize();

  await NotificationService.initializeNotifications();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final personApi =
      PersonLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final settingsApi =
      SettingsLocalDataSource(sharedPreferences: sharedPreferences);

  final personRepository = PersonRepository(localDataSource: personApi);
  final settingsRepository = SettingsRepository(localDataSource: settingsApi);

  runApp(App(
    personRepository: personRepository,
    settingsRepository: settingsRepository,
  ));
}
