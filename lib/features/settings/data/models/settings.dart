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
  final String theme;

  @override
  List<Object?> get props => [notificationDay, language, dateFormat, theme];
}
