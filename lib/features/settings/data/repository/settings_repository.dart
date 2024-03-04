import 'package:birthdays_reminder/core/error/exception.dart';
import 'package:birthdays_reminder/core/error/failure.dart';
import 'package:birthdays_reminder/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:birthdays_reminder/features/settings/data/models/settings.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:dartz/dartz.dart';

class SettingsRepository implements AbstractSettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepository({required this.localDataSource});
  @override
  Future<Either<Failure, String>> getDateFormat() async {
    try {
      final dateFormat = await localDataSource.getDateFormatFromCache();
      return Right(dateFormat);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getLanguage() async {
    try {
      final lang = await localDataSource.getLanguageFromCache();
      return Right(lang);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getNotificationDay() async {
    try {
      final notificationDay =
          await localDataSource.getNotificationDayFromCache();
      return Right(notificationDay);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getTheme() async {
    try {
      final theme = await localDataSource.getThemeFromCache();
      return Right(theme);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setDateFormat(String dateFormat) async {
    try {
      return Right(await localDataSource.dateFormatToCache(dateFormat));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setLanguage(String lang) async {
    try {
      return Right(await localDataSource.languageToCache(lang));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setNotificationDay(int notificationDay) async {
    try {
      return Right(
          await localDataSource.notificationDayToCache(notificationDay));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setTheme(AppThemeMode theme) async {
    try {
      return Right(await localDataSource.themeToCache(theme));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, SettingsModel>> getSettingsData() async {
    String dateFormat = '';
    String language = '';
    int notificationDay = 0;
    AppThemeMode theme = AppThemeMode.system;
    try {
      (await getDateFormat())
          .fold((failure) => CacheFailure(), (result) => dateFormat = result);
      (await getLanguage())
          .fold((failure) => CacheFailure(), (result) => language = result);
      (await getNotificationDay()).fold(
          (failure) => CacheFailure(), (result) => notificationDay = result);
      (await getTheme()).fold((failure) => CacheFailure(), (result) {
        switch (result) {
          case "system":
            theme = AppThemeMode.system;
            break;
          case "dark":
            theme = AppThemeMode.dark;
            break;
          case "light":
            theme = AppThemeMode.light;
            break;
        }
      });
      return (Right(SettingsModel(
          notificationDay: notificationDay,
          language: language,
          dateFormat: dateFormat,
          theme: theme)));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
