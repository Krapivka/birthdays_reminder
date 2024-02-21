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

  @override
  List<Object?> get props => [id, name, birthdate, listOfGifts];
}
