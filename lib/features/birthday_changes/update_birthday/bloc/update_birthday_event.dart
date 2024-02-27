part of 'update_birthday_bloc.dart';

sealed class UpdateBirthdayEvent extends Equatable {
  const UpdateBirthdayEvent();

  @override
  List<Object> get props => [];
}

class UpdateBirtdayNameChanged extends UpdateBirthdayEvent {
  const UpdateBirtdayNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class UpdateBirtdayImageTap extends UpdateBirthdayEvent {
  const UpdateBirtdayImageTap();

  @override
  List<Object> get props => [];
}

class UpdateBirtdayDateTap extends UpdateBirthdayEvent {
  const UpdateBirtdayDateTap(this.birthdate);

  final DateTime birthdate;

  @override
  List<Object> get props => [birthdate];
}

final class UpdateBirthdaySave extends UpdateBirthdayEvent {
  const UpdateBirthdaySave();
  @override
  List<Object> get props => [];
}
