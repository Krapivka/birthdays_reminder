import 'dart:async';

import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adding_birthday_event.dart';
part 'adding_birthday_state.dart';

class AddingBirthdayBloc
    extends Bloc<AddingBirthdayEvent, AddingBirthdayState> {
  AddingBirthdayBloc(this._personRepository) : super(AddingBirthdayState()) {
    on<AddingBirtdayNameChanged>(_onNameChanged);
    on<AddingBirtdayDateTap>(_onDateChanged);
    on<AddingBirthdaySubmitted>(_onSubmitted);
  }

  final PersonRepository _personRepository;

  void _onNameChanged(
      AddingBirtdayNameChanged event, Emitter<AddingBirthdayState> emit) {
    debugPrint("Name: ${event.name}");
    emit(state.copyWith(name: event.name));
  }

  void _onDateChanged(
      AddingBirtdayDateTap event, Emitter<AddingBirthdayState> emit) {
    debugPrint("Date: ${event.birthdate}");
    emit(state.copyWith(birthdate: event.birthdate));
  }

  void _onSubmitted(
      AddingBirthdaySubmitted event, Emitter<AddingBirthdayState> emit) async {
    emit(state.copyWith(status: AddingBirthdayStatus.loading));
    try {
      final length = await _personRepository.getLength();
      PersonModel person = PersonModel(
          id: length + 1,
          name: state.name,
          birthdate: state.birthdate, //validation для полей! обязательно
          listOfGifts: const []);
      await _personRepository.addPerson(person);
      debugPrint("Add new Person: ${person.name}");
      emit(state.copyWith(status: AddingBirthdayStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddingBirthdayStatus.failure));
    } finally {
      Completer.sync().complete();
    }
  }
}
