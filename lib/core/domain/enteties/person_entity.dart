import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final DateTime birthdate;
  final List<String>? listOfGifts;
  PersonEntity(
      {required this.id,
      required this.name,
      required this.birthdate,
      this.listOfGifts});

  @override
  List<Object?> get props => [id, name, birthdate, listOfGifts];
}
