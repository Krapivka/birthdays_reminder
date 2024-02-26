import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'birthdays_list_event.dart';
part 'birthdays_list_state.dart';

class BirthdaysListBloc extends Bloc<BirthdaysListEvent, BirthdaysListState> {
  BirthdaysListBloc(this._personRepository)
      : super(
          const BirthdaysListState(
            birthdayListStatus: BirthdaysListStatus.initial,
            listPersonModel: [],
            selectedPersonId: [],
            sortedListPersonModel: [],
          ),
        ) {
    on<LoadBirthdaysListEvent>(_onLoadBirthdaysList);
    on<SearchBirthdaysListEvent>(_onSearchPerson);
    on<LongPressBirthdayCardEvent>(_onLongPressBirthdayCardEvent);
    on<TapBirthdayCardEvent>(_onTapBirthdayCardEvent);
    on<DeletePersonBirthdaysListEvent>(_onDeletePerson);
  }
  final PersonRepository _personRepository;

  _onLoadBirthdaysList(
      LoadBirthdaysListEvent event, Emitter<BirthdaysListState> emit) async {
    emit(state.copyWith(birthdayListStatus: BirthdaysListStatus.loading));
    final listPersonModel = await _personRepository.getAllPersons();
    listPersonModel.fold(
      (failure) =>
          emit(state.copyWith(birthdayListStatus: BirthdaysListStatus.failure)),
      (result) => emit(state.copyWith(
          birthdayListStatus: BirthdaysListStatus.loaded,
          listPersonModel:
              sortPersonsByNearestBirthday(result as List<PersonModel>))),
    );
  }

  _onSearchPerson(
      SearchBirthdaysListEvent event, Emitter<BirthdaysListState> emit) async {
    emit(state.copyWith(birthdayListStatus: BirthdaysListStatus.loading));
    final listPersonModel = await _personRepository.getAllPersons();
    listPersonModel.fold(
        (failure) => emit(
            state.copyWith(birthdayListStatus: BirthdaysListStatus.failure)),
        (result) {
      if (result.isEmpty || event.query == '') {
        emit(state.copyWith(
            birthdayListStatus: BirthdaysListStatus.loaded,
            listPersonModel:
                sortPersonsByNearestBirthday(result as List<PersonModel>)));
      } else {
        final query = event.query;

        debugPrint("Search: ${event.query}");
        final sortedList = result
            .where((person) =>
                person.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        emit(
          state.copyWith(
              birthdayListStatus: BirthdaysListStatus.searchLoaded,
              sortedListPersonModel: sortPersonsByNearestBirthday(
                  sortedList as List<PersonModel>)),
        );
      }
    });
  }

  _onLongPressBirthdayCardEvent(
      LongPressBirthdayCardEvent event, Emitter<BirthdaysListState> emit) {
    List<int> selectedPersonId = state.selectedPersonId;
    if (state.selectedPersonId.contains(event.id)) {
      selectedPersonId.remove(event.id);
    } else {
      selectedPersonId = [...state.selectedPersonId, event.id];
    }
    emit(state.copyWith(selectedPersonId: selectedPersonId));
    debugPrint("${state.selectedPersonId}");
  }

  _onTapBirthdayCardEvent(
      TapBirthdayCardEvent event, Emitter<BirthdaysListState> emit) {
    List<int> selectedPersonId = state.selectedPersonId;

    if (state.selectedPersonId.isNotEmpty &&
        state.selectedPersonId.contains(event.id)) {
      selectedPersonId.remove(event.id);
    } else if (state.selectedPersonId.isNotEmpty) {
      selectedPersonId = [...state.selectedPersonId, event.id];
    }
    emit(state.copyWith(selectedPersonId: selectedPersonId));
    debugPrint("${state.selectedPersonId}");
  }

  _onDeletePerson(DeletePersonBirthdaysListEvent event,
      Emitter<BirthdaysListState> emit) async {
    for (int id in state.selectedPersonId) {
      final delPerson = await _personRepository.deletePerson(id);
      delPerson.fold(
          (failure) => emit(
              state.copyWith(birthdayListStatus: BirthdaysListStatus.failure)),
          (result) async {
        ///Cancel scheduling notifications

        await AwesomeNotifications().cancel(id);
        debugPrint("Delete Person with ID: ${id}");
      });
    }
    emit(state.copyWith(
        selectedPersonId: [],
        birthdayListStatus: BirthdaysListStatus.selectedBirthdaysDeleted));
    add(const LoadBirthdaysListEvent());
  }
}

List<PersonModel> sortPersonsByNearestBirthday(List<PersonModel> persons) {
  DateTime today = DateTime.now();
  DateTime yesterday = today.subtract(Duration(days: 1));

  persons.sort((a, b) {
    DateTime aNextBirthday =
        DateTime(today.year, a.birthdate.month, a.birthdate.day);
    DateTime bNextBirthday =
        DateTime(today.year, b.birthdate.month, b.birthdate.day);
    if (aNextBirthday.isBefore(yesterday)) {
      aNextBirthday = aNextBirthday.add(Duration(days: 365));
    }
    if (bNextBirthday.isBefore(yesterday)) {
      bNextBirthday = bNextBirthday.add(Duration(days: 365));
    }
    int result = aNextBirthday.compareTo(bNextBirthday);
    if (result == 0) {
      result = a.id.compareTo(b.id);
    }
    return result;
  });
  return persons;
}
