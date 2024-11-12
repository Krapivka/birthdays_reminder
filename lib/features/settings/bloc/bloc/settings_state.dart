part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, success, login, failure }

class SettingsState extends Equatable {
  ///Field [dayTimeNotification] shows how many days are left before the birthday notification
  ///and time notification
  SettingsState({dayTimeNotification, status, language, dateFormat, theme})
      : dayTimeNotification = dayTimeNotification ??
            DayTimeNotification(day: 0, hour: 0, minute: 0),
        status = status ?? SettingsStatus.initial,
        language = language ?? '',
        dateFormat = dateFormat ?? '',
        theme = theme ?? AppThemeMode.system;

  final DayTimeNotification dayTimeNotification;
  final SettingsStatus status;
  final String language;
  final String dateFormat;
  final AppThemeMode theme;
  @override
  List<Object> get props =>
      [dayTimeNotification, status, language, dateFormat, theme];

  SettingsState copyWith({
    DayTimeNotification? dayTimeNotification,
    String? language,
    String? dateFormat,
    AppThemeMode? theme,
    SettingsStatus? status,
  }) {
    return SettingsState(
      status: status ?? this.status,
      dayTimeNotification: dayTimeNotification ?? this.dayTimeNotification,
      language: language ?? this.language,
      dateFormat: dateFormat ?? this.dateFormat,
      theme: theme ?? this.theme,
    );
  }
}
