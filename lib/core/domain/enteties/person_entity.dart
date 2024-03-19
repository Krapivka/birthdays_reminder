import 'package:birthdays_reminder/core/utils/date_utils/date_utils.dart';
import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String filePath;
  final String name;
  final DateTime birthdate;
  final List<String>? listOfGifts;
  const PersonEntity(
      {required this.id,
      required this.filePath,
      required this.name,
      required this.birthdate,
      this.listOfGifts});

  String get getNextAge =>
      (DateTimeUtils.calculateAge(birthdate) + 1).toString();

  String get getHowManyDaysBirthday =>
      DateTimeUtils.getDifferenceCurrentDayBirthDay(birthdate);

  @override
  List<Object?> get props => [id, name, birthdate, listOfGifts];
}
