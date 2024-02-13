import 'package:birthdays_reminder/core/error/failure.dart';
import 'package:birthdays_reminder/features/settings/data/models/settings.dart';
import 'package:dartz/dartz.dart';

abstract class AbstractSettingsRepository {
  Future<Either<Failure, int>> getNotificationDay();
  Future<Either<Failure, void>> setNotificationDay(int notificationDay);
  Future<Either<Failure, String>> getLanguage();
  Future<Either<Failure, void>> setLanguage(String lang);
  Future<Either<Failure, String>> getDateFormat();
  Future<Either<Failure, void>> setDateFormat(String dateFormat);
  Future<Either<Failure, String>> getTheme();
  Future<Either<Failure, void>> setTheme(String theme);
  Future<Either<Failure, SettingsModel>> getSettingsData();
}
