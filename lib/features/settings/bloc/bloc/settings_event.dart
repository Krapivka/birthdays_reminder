part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class InitializeSettingsEvent extends SettingsEvent {
  const InitializeSettingsEvent();
}

class SetNotificationDayTimeEvent extends SettingsEvent {
  const SetNotificationDayTimeEvent(this.dayTimeNotification);

  final DayTimeNotification dayTimeNotification;
  @override
  List<Object> get props => [dayTimeNotification];
}

class SetLanguageEvent extends SettingsEvent {
  const SetLanguageEvent(this.language);

  final String language;
  @override
  List<Object> get props => [language];
}

class SetDateFormatEvent extends SettingsEvent {
  const SetDateFormatEvent(this.dateFormat);

  final String dateFormat;
  @override
  List<Object> get props => [dateFormat];
}

class SetThemeEvent extends SettingsEvent {
  const SetThemeEvent(this.theme);

  final AppThemeMode theme;
  @override
  List<Object> get props => [theme];
}
