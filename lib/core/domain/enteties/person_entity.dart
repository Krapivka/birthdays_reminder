import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String day;
  final String month;
  final String year;
  final List<String> listOfGifts;
  PersonEntity(
      {required this.id,
      required this.name,
      required this.day,
      required this.month,
      required this.year,
      required this.listOfGifts});

  @override
  List<Object?> get props => [id, name, day, month, year, listOfGifts];
}
