part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarDateTap extends CalendarEvent {
  const CalendarDateTap(this.birthdate);

  final DateTime birthdate;

  @override
  List<Object> get props => [birthdate];
}

class LoadBirthdaysCalendar extends CalendarEvent {
  const LoadBirthdaysCalendar();

  @override
  List<Object> get props => [];
}
