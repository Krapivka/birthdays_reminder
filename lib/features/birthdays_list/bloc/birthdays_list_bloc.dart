import 'dart:async';

import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'birthdays_list_event.dart';
part 'birthdays_list_state.dart';

class BirthdaysListBloc extends Bloc<BirthdaysListEvent, BirthdaysListState> {
  BirthdaysListBloc(this._personRepository) : super(BirthdaysListInitial()) {
    on<LoadBirthdaysListEvent>(_onLoadBirthdaysList);
    on<SearchBirthdaysListEvent>(_onSearchPerson);
    on<DeletePersonBirthdaysListEvent>(_onDeletePerson);
  }
  final PersonRepository _personRepository;

  _onLoadBirthdaysList(
      LoadBirthdaysListEvent event, Emitter<BirthdaysListState> emit) async {
    emit(BirthdaysListLoading());
    final listPersonModel = await _personRepository.getAllPersons();
    listPersonModel.fold(
        (failure) => emit(BirthdaysListFailure()),
        (result) => emit(
            BirthdaysListLoaded(listPersonModel: result as List<PersonModel>)));
  }

  _onSearchPerson(
      SearchBirthdaysListEvent event, Emitter<BirthdaysListState> emit) async {
    emit(BirthdaysListLoading());
    final listPersonModel = await _personRepository.getAllPersons();
    listPersonModel.fold((failure) => emit(BirthdaysListFailure()), (result) {
      if (result == []) {
        emit(SearchBirthdaysListEmpty());
      } else {
        final query = event.query;
        debugPrint("Search: ${event.query}");
        final sortedList = result
            .where((person) =>
                person.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(SearchBirthdaysListLoaded(
            sortedListPersonModel: sortedList as List<PersonModel>));
      }
    });
  }

  _onDeletePerson(DeletePersonBirthdaysListEvent event,
      Emitter<BirthdaysListState> emit) async {
    final delPerson = await _personRepository.deletePerson(event.id);
    delPerson.fold((failure) => emit(BirthdaysListFailure()),
        (result) => add(const LoadBirthdaysListEvent()));
  }
}
