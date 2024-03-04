import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractSettingsLocalDataSource {
  Future<int> getNotificationDayFromCache();
  Future<void> notificationDayToCache(int notificationDay);
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
  static const String keyNotifications = 'notifications';
  static const String keyLanguage = 'language';
  static const String keyDateFormat = 'date_format';
  static const String keyTheme = 'theme';

  SharedPreferences sharedPreferences;

  SettingsLocalDataSource({required this.sharedPreferences});

  @override
  Future<int> getNotificationDayFromCache() async {
    return sharedPreferences.getInt(keyNotifications) ?? 10;
  }

  @override
  Future<void> notificationDayToCache(int notificationDay) async {
    await sharedPreferences.setInt(keyNotifications, notificationDay);
  }

  @override
  Future<String> getLanguageFromCache() async {
    return sharedPreferences.getString(keyLanguage) ??
        'en'; // Значение по умолчанию - 'en'
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
}
