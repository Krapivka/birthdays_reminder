part of 'update_birthday_bloc.dart';

enum UpdateBirthdayStatus { initial, loading, success, failure }

final currentDate = DateTime.now();

class UpdateBirthdayState extends Equatable {
  UpdateBirthdayState({
    this.id = 0,
    file,
    this.status = UpdateBirthdayStatus.initial,
    this.name = '',
    birthdate,
  })  : birthdate = birthdate ?? DateTime.now(),
        file = file ?? File('');

  UpdateBirthdayState.personModel({required PersonModel person})
      : name = person.name,
        birthdate = person.birthdate,
        status = UpdateBirthdayStatus.initial,
        file = File(person.filePath),
        id = person.id;

  UpdateBirthdayStatus status;
  final int id;
  final File file;
  final String name;
  final DateTime birthdate;
  @override
  List<Object> get props => [id, file, status, name, birthdate];

  UpdateBirthdayState copyWith(
      {int? id,
      UpdateBirthdayStatus? status,
      File? file,
      String? name,
      DateTime? birthdate}) {
    return UpdateBirthdayState(
      id: id ?? this.id,
      file: file ?? this.file,
      status: status ?? this.status,
      name: name ?? this.name,
      birthdate: birthdate ?? this.birthdate,
    );
  }
}
