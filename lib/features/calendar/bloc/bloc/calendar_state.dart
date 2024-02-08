part of 'calendar_bloc.dart';

enum CalendarStatus { initial, loading, success, failure }

class CalendarState extends Equatable {
  CalendarState({
    this.status = CalendarStatus.initial,
    birthdays,
    birthdaysInSelectedDay,
  })  : birthdays = birthdays ?? LinkedHashMap<DateTime, List<PersonModel>>(),
        birthdaysInSelectedDay = birthdaysInSelectedDay ?? [];

  LinkedHashMap<DateTime, List<PersonModel>> birthdays;
  List<PersonModel> birthdaysInSelectedDay;
  CalendarStatus status;

  @override
  List<Object> get props => [status, birthdays, birthdaysInSelectedDay];

  CalendarState copyWith({
    LinkedHashMap<DateTime, List<PersonModel>>? birthdays,
    List<PersonModel>? birthdaysInSelectedDay,
    CalendarStatus? status,
  }) {
    return CalendarState(
      status: status ?? this.status,
      birthdays: birthdays ?? this.birthdays,
      birthdaysInSelectedDay:
          birthdaysInSelectedDay ?? this.birthdaysInSelectedDay,
    );
  }
}
