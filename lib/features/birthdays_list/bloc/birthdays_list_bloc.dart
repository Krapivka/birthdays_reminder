import 'dart:async';

import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'birthdays_list_event.dart';
part 'birthdays_list_state.dart';

class BirthdaysListBloc extends Bloc<BirthdaysListEvent, BirthdaysListState> {
  BirthdaysListBloc(this._personRepository) : super(BirthdaysListInitial()) {
    on<LoadBirthdaysListEvent>(_onLoadBirthdaysList);
  }
  final PersonRepository _personRepository;
  _onLoadBirthdaysList(
      LoadBirthdaysListEvent event, Emitter<BirthdaysListState> emit) async {
    final listPersonModel = await _personRepository.getAllPersons();
    listPersonModel.fold(
        (failure) => emit(BirthdaysListFailure()),
        (result) => emit(
            BirthdaysListLoaded(listPersonModel: result as List<PersonModel>)));
  }
}
