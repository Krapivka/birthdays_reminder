import 'dart:collection';

import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final AbstractPersonRepository _personRepository;

  CalendarBloc(this._personRepository) : super(CalendarState()) {
    on<LoadBirthdaysCalendar>(_onLoadBirthdaysCalendar);
    on<CalendarDateTap>(_onCalendarDateTap);
  }

  void _onLoadBirthdaysCalendar(
      LoadBirthdaysCalendar event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(status: CalendarStatus.loading));
    final listPersonModel = await _personRepository.getAllPersons();

    listPersonModel
        .fold((failure) => emit(state.copyWith(status: CalendarStatus.failure)),
            (result) {
      Map<DateTime, List<PersonModel>> birthdaySource = {};

      for (var person in result as List<PersonModel>) {
        var dateKey = DateTime(
            DateTime.now().year, person.birthdate.month, person.birthdate.day);
        birthdaySource.putIfAbsent(dateKey, () => []);
        birthdaySource[dateKey]!.add(person);
      }

      final birthdays = LinkedHashMap<DateTime, List<PersonModel>>(
        equals: isSameDay,
        hashCode: getHashCode,
      )..addAll(birthdaySource);

      emit(
          state.copyWith(status: CalendarStatus.success, birthdays: birthdays));
    });
  }

  void _onCalendarDateTap(
      CalendarDateTap event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(status: CalendarStatus.loading));
    final List<PersonModel> birthdaysInSelectedDay =
        state.birthdays[event.birthdate] ?? [];

    emit(state.copyWith(
        status: CalendarStatus.success,
        birthdaysInSelectedDay: birthdaysInSelectedDay));
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
