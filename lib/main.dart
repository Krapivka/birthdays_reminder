import 'package:birthdays_reminder/core/data/datasources/person_local_data_source.dart';
import 'package:birthdays_reminder/core/data/repositories/person_repository_impl.dart';
import 'package:birthdays_reminder/core/services/ads/yandex_ads/open/open_ad_manager.dart';
import 'package:birthdays_reminder/core/services/notification/notification_service.dart';
import 'package:birthdays_reminder/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:birthdays_reminder/features/settings/data/repository/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import 'birthdays_reminder_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.initialize();

  await NotificationService.initializeNotifications();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final appOpenAdManager = AppOpenAdManager();
  await appOpenAdManager.loadAppOpenAd();
  await appOpenAdManager.showAd();

  final personApi =
      PersonLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  final settingsApi =
      SettingsLocalDataSource(sharedPreferences: sharedPreferences);

  final personRepository = PersonRepository(localDataSource: personApi);
  final settingsRepository = SettingsRepository(localDataSource: settingsApi);

  runApp(App(
    appOpenAdManager: appOpenAdManager,
    personRepository: personRepository,
    settingsRepository: settingsRepository,
  ));
}
