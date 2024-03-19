import 'dart:async';
import 'dart:io';

import 'package:birthdays_reminder/core/services/image_picker/image_picker_service.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/services/notification/notification_service.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adding_birthday_event.dart';
part 'adding_birthday_state.dart';

class AddingBirthdayBloc
    extends Bloc<AddingBirthdayEvent, AddingBirthdayState> {
  AddingBirthdayBloc(this._personRepository, this._settingsRepository)
      : super(AddingBirthdayState()) {
    on<AddingBirtdayNameChanged>(_onNameChanged);
    on<AddingBirtdayDateTap>(_onDateTap);
    on<AddingBirtdayImageTap>(_onImageTap);
    on<AddingBirthdaySubmitted>(_onSubmitted);
  }

  final AbstractPersonRepository _personRepository;
  final AbstractSettingsRepository _settingsRepository;
  //final AppImagePicker _imagePicker;

  void _onImageTap(
      AddingBirtdayImageTap event, Emitter<AddingBirthdayState> emit) async {
    final File? file = await AppImagePickerService.getImageFromGallery();

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
  }

  void _onSubmitted(
      AddingBirthdaySubmitted event, Emitter<AddingBirthdayState> emit) async {
    emit(state.copyWith(status: AddingBirthdayStatus.loading));

    try {
      if (state.name != '') {
        //preparing the model for creation
        final lastInd = await _personRepository.lastIndex();
        PersonModel person = PersonModel(
            id: lastInd + 1,
            filePath: state.file.absolute.path,
            name: state.name,
            birthdate: state.birthdate,
            listOfGifts: const []);

        //adding to the local storage
        await _personRepository.addPerson(person);

        //scheduling notifications
        final notificationInterval =
            await _settingsRepository.getNotificationDayTime();
        notificationInterval.fold(
            (failure) =>
                emit(state.copyWith(status: AddingBirthdayStatus.failure)),
            (result) async {
          final birthday = state.birthdate;
          await NotificationService.scheduleBirthdayNotification(
              person: person,
              id: person.id,
              interval: result.day,
              birthday: birthday,
              hourNotif: result.hour,
              minuteNotif: result.minute);
        });

        debugPrint("Add new Birthday for: ${person.name}");
        emit(state.copyWith(status: AddingBirthdayStatus.success));
      } else {
        emit(state.copyWith(status: AddingBirthdayStatus.validatorFailure));
        emit(state.copyWith(status: AddingBirthdayStatus.initial));
      }
    } catch (e) {
      emit(state.copyWith(status: AddingBirthdayStatus.failure));
    } finally {
      Completer.sync().complete();
    }
  }
}
