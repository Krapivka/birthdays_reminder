import 'dart:async';
import 'dart:io';

import 'package:birthdays_reminder/core/data/services/image_picker.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_birthday_event.dart';
part 'update_birthday_state.dart';

class UpdateBirthdayBloc
    extends Bloc<UpdateBirthdayEvent, UpdateBirthdayState> {
  UpdateBirthdayBloc(this._personRepository, this._imagePicker, person)
      : super(UpdateBirthdayState.personModel(person: person)) {
    on<UpdateBirtdayNameChanged>(_onNameChanged);
    on<UpdateBirtdayDateTap>(_onDateTap);
    on<UpdateBirtdayImageTap>(_onImageTap);
    on<UpdateBirthdaySave>(_onSave);
  }

  final PersonRepository _personRepository;

  final AppImagePicker _imagePicker;

  void _onImageTap(
      UpdateBirtdayImageTap event, Emitter<UpdateBirthdayState> emit) async {
    final File? file = await _imagePicker.getImageFromGallery();

    emit(state.copyWith(file: file));
  }

  void _onNameChanged(
      UpdateBirtdayNameChanged event, Emitter<UpdateBirthdayState> emit) {
    debugPrint("Name: ${event.name}");
    emit(state.copyWith(name: event.name));
  }

  void _onDateTap(
      UpdateBirtdayDateTap event, Emitter<UpdateBirthdayState> emit) {
    debugPrint("Date: ${event.birthdate}");
    emit(state.copyWith(birthdate: event.birthdate));
    debugPrint("Date: ${state.birthdate}");
  }

  void _onSave(
      UpdateBirthdaySave event, Emitter<UpdateBirthdayState> emit) async {
    emit(state.copyWith(status: UpdateBirthdayStatus.loading));

    try {
      PersonModel person = PersonModel(
          id: state.id,
          filePath: state.file.absolute.path,
          name: state.name,
          birthdate: state.birthdate,
          listOfGifts: const []);

      final updatePerson = await _personRepository.updatePerson(person);

      updatePerson.fold(
          (failure) =>
              emit(state.copyWith(status: UpdateBirthdayStatus.failure)),
          (result) {
        debugPrint("Update Person with id: ${person.id}");
        emit(state.copyWith(status: UpdateBirthdayStatus.success));
      });
    } catch (e) {
      emit(state.copyWith(status: UpdateBirthdayStatus.failure));
    } finally {
      Completer.sync().complete();
    }
  }
}