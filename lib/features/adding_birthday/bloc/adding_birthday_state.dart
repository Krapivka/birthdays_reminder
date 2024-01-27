part of 'adding_birthday_bloc.dart';

enum AddingBirthdayStatus { initial, loading, success, failure }

class AddingBirthdayState extends Equatable {
  AddingBirthdayState({
    this.status = AddingBirthdayStatus.initial,
    this.name = '',
    birthdate,
  }) : birthdate = birthdate ?? DateTime.now();

  AddingBirthdayStatus status;
  final String name;
  final DateTime birthdate;
  @override
  List<Object> get props => [status, name];

  AddingBirthdayState copyWith(
      {AddingBirthdayStatus? status, String? name, DateTime? birthdate}) {
    return AddingBirthdayState(
      status: status ?? this.status,
      name: name ?? this.name,
      birthdate: birthdate ?? this.birthdate,
    );
  }
}
