import 'package:birthdays_reminder/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  const SettingsModel(
      {required this.notificationDay,
      required this.language,
      required this.dateFormat,
      required this.theme});
  final int notificationDay;
  final String language;
  final String dateFormat;
  final AppThemeMode theme;

  @override
  List<Object?> get props => [notificationDay, language, dateFormat, theme];
}
