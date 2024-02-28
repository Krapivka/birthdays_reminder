part of 'adding_birthday_bloc.dart';

enum AddingBirthdayStatus {
  initial,
  loading,
  validatorFailure,
  success,
  failure
}

final currentDate = DateTime.now();

class AddingBirthdayState extends Equatable {
  AddingBirthdayState({
    file,
    this.status = AddingBirthdayStatus.initial,
    this.name = '',
    birthdate,
  })  : birthdate = birthdate ?? DateTime.now(),
        file = file ?? File('');

  AddingBirthdayStatus status;
  final File file;
  final String name;
  final DateTime birthdate;
  @override
  List<Object> get props => [file, status, name, birthdate];

  AddingBirthdayState copyWith(
      {AddingBirthdayStatus? status,
      File? file,
      String? name,
      DateTime? birthdate}) {
    return AddingBirthdayState(
      file: file ?? this.file,
      status: status ?? this.status,
      name: name ?? this.name,
      birthdate: birthdate ?? this.birthdate,
    );
  }
}
