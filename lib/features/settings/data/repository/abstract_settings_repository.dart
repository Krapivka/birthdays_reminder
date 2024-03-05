import 'package:birthdays_reminder/core/error/failure.dart';
import 'package:birthdays_reminder/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:birthdays_reminder/features/settings/data/models/day_time_notification.dart';
import 'package:birthdays_reminder/features/settings/data/models/settings.dart';
import 'package:dartz/dartz.dart';

abstract interface class AbstractSettingsRepository {
  Future<Either<Failure, DayTimeNotification>> getNotificationDayTime();
  Future<Either<Failure, void>> setNotificationDayTime(
      DayTimeNotification notificationDay);
  Future<Either<Failure, String>> getLanguage();
  Future<Either<Failure, void>> setLanguage(String lang);
  Future<Either<Failure, String>> getDateFormat();
  Future<Either<Failure, void>> setDateFormat(String dateFormat);
  Future<Either<Failure, String>> getTheme();
  Future<Either<Failure, void>> setTheme(AppThemeMode theme);
  Future<Either<Failure, SettingsModel>> getSettingsData();
}
