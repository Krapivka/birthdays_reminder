part of 'adding_birthday_bloc.dart';

sealed class AddingBirthdayEvent extends Equatable {
  const AddingBirthdayEvent();

  @override
  List<Object> get props => [];
}

class AddingBirtdayNameChanged extends AddingBirthdayEvent {
  const AddingBirtdayNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class AddingBirtdayDateTap extends AddingBirthdayEvent {
  const AddingBirtdayDateTap(this.birthdate);

  final DateTime birthdate;

  @override
  List<Object> get props => [birthdate];
}

final class AddingBirthdaySubmitted extends AddingBirthdayEvent {
  const AddingBirthdaySubmitted();
}
