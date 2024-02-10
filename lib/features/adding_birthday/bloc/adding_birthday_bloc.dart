import 'dart:async';
import 'dart:io';

import 'package:birthdays_reminder/core/data/services/image_picker.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/data/services/notification_service.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adding_birthday_event.dart';
part 'adding_birthday_state.dart';

class AddingBirthdayBloc
    extends Bloc<AddingBirthdayEvent, AddingBirthdayState> {
  AddingBirthdayBloc(this._personRepository, this._imagePicker)
      : super(AddingBirthdayState()) {
    on<AddingBirtdayNameChanged>(_onNameChanged);
    on<AddingBirtdayDateTap>(_onDateTap);
    on<AddingBirtdayImageTap>(_onImageTap);
    on<AddingBirthdaySubmitted>(_onSubmitted);
  }

  final PersonRepository _personRepository;

  final AppImagePicker _imagePicker;

  void _onImageTap(
      AddingBirtdayImageTap event, Emitter<AddingBirthdayState> emit) async {
    final File? file = await _imagePicker.getImageFromGallery();

    emit(state.copyWith(file: file));
  }

  void _onNameChanged(
      AddingBirtdayNameChanged event, Emitter<AddingBirthdayState> emit) {
    debugPrint("Name: ${event.name}");
    emit(state.copyWith(name: event.name));
  }

  void _onDateTap(
      AddingBirtdayDateTap event, Emitter<AddingBirthdayState> emit) {
    debugPrint("Date: ${event.birthdate}");
    emit(state.copyWith(birthdate: event.birthdate));
    debugPrint("Date: ${state.birthdate}");
  }

  void _onSubmitted(
      AddingBirthdaySubmitted event, Emitter<AddingBirthdayState> emit) async {
    emit(state.copyWith(status: AddingBirthdayStatus.loading));

    try {
      final lastInd = await _personRepository.lastIndex();

      PersonModel person = PersonModel(
          id: lastInd + 1,
          filePath: state.file.absolute.path,
          name: state.name,
          birthdate: state.birthdate ??
              DateTime.now(), //validation для полей! обязательно
          listOfGifts: const []);
      await _personRepository.addPerson(person);
      //show notification !!!

      final moonLanding = DateTime.parse('2024-02-10 18:10:00Z');
      await NotificationService.showScheduleNotification(
        title: "Schedule Notification",
        scheduleTime: moonLanding,
      );

      debugPrint("Add new Person: ${person.name}");
      emit(state.copyWith(status: AddingBirthdayStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddingBirthdayStatus.failure));
    } finally {
      Completer.sync().complete();
    }
  }
}
