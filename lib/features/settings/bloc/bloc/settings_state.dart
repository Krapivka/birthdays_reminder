part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, success, failure }

class SettingsState extends Equatable {
  ///Field [notificationDay] shows how many days are left before the birthday notification
  const SettingsState({notificationDay, status, language, dateFormat, theme})
      : notificationDay = notificationDay ?? 0,
        status = status ?? SettingsStatus.initial,
        language = language ?? '',
        dateFormat = dateFormat ?? '',
        theme = theme ?? '';

  final int notificationDay;
  final SettingsStatus status;
  final String language;
  final String dateFormat;
  final String theme;
  @override
  List<Object> get props =>
      [notificationDay, status, language, dateFormat, theme];

  SettingsState copyWith({
    int? notificationDay,
    String? language,
    String? dateFormat,
    String? theme,
    SettingsStatus? status,
  }) {
    return SettingsState(
      status: status ?? this.status,
      notificationDay: notificationDay ?? this.notificationDay,
      language: language ?? this.language,
      dateFormat: dateFormat ?? this.dateFormat,
      theme: theme ?? this.theme,
    );
  }
}
