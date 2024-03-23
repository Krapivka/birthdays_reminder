import 'package:birthdays_reminder/features/settings/data/models/day_time_notification.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AbstractSettingsLocalDataSource {
  Future<DayTimeNotification> getNotificationDayTimeNotificationFromCache();
  Future<void> notificationDayTimeNotificationToCache(
      DayTimeNotification dayTime);
  Future<String> getLanguageFromCache();
  Future<void> languageToCache(String lang);
  Future<String> getDateFormatFromCache();
  Future<void> dateFormatToCache(String dateFormat);
  Future<String> getThemeFromCache();
  Future<void> themeToCache(AppThemeMode appThemeMode);
}

enum AppThemeMode {
  system("system", ThemeMode.system),
  light("light", ThemeMode.light),
  dark("dark", ThemeMode.dark);

  const AppThemeMode(this.localization, this.themeMode);
  final ThemeMode themeMode;
  final String localization;
}

class SettingsLocalDataSource extends AbstractSettingsLocalDataSource {
  static const String keyDayTimeNotification = 'day_time_notification';
  static const String keyLanguage = 'language';
  static const String keyDateFormat = 'date_format';
  static const String keyTheme = 'theme';

  SharedPreferences sharedPreferences;

  SettingsLocalDataSource({required this.sharedPreferences});

  @override
  Future<DayTimeNotification>
      getNotificationDayTimeNotificationFromCache() async {
    String? dayTimeNotification =
        sharedPreferences.getString(keyDayTimeNotification);
    if (dayTimeNotification != null) {
      return DayTimeNotification.fromJson(dayTimeNotification);
    }
    // Значение по умолчанию - day 10, hour 11, minute 0
    return DayTimeNotification(day: 10, hour: 11, minute: 0);
  }

  @override
  Future<void> notificationDayTimeNotificationToCache(
      DayTimeNotification dayTime) async {
    await sharedPreferences.setString(keyDayTimeNotification, dayTime.toJson());
  }

  @override
  Future<String> getLanguageFromCache() async {
    return sharedPreferences.getString(keyLanguage) ??
        'ru'; // Значение по умолчанию - 'ru'
  }

  @override
  Future<void> languageToCache(String lang) async {
    await sharedPreferences.setString(keyLanguage, lang);
  }

  @override
  Future<String> getDateFormatFromCache() async {
    return sharedPreferences.getString(keyDateFormat) ??
        'dd/MM/yyyy'; // Значение по умолчанию - 'dd/MM/yyyy'
  }

  @override
  Future<void> dateFormatToCache(String dateFormat) async {
    await sharedPreferences.setString(keyDateFormat, dateFormat);
  }

  @override
  Future<String> getThemeFromCache() async {
    return sharedPreferences.getString(keyTheme) ??
        "system"; // Значение по умолчанию - 'light'
  }

  @override
  Future<void> themeToCache(AppThemeMode appThemeMode) async {
    await sharedPreferences.setString(keyTheme, appThemeMode.localization);
  }

  getDayTimeNotificationFromCache() {}

  notificationDayToCache(int notificationDay) {}
}
