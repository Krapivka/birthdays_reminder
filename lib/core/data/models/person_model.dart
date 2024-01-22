import 'package:birthdays_reminder/core/domain/enteties/person_entity.dart';

class PersonModel extends PersonEntity {
  PersonModel(
      {required super.id,
      required super.name,
      required super.day,
      required super.month,
      required super.year,
      required super.listOfGifts});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
        id: json['id'],
        name: json['name'],
        day: json['day'],
        month: json['month'],
        year: json['year'],
        listOfGifts: json['listOfGifts']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'day': day,
      'month': month,
      'year': year,
      'listOfGifts': listOfGifts
    };
  }
}
