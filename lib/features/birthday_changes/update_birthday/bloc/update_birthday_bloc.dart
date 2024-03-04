import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:birthdays_reminder/core/services/image_picker/image_picker_service.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/services/notification/notification_service.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_birthday_event.dart';
part 'update_birthday_state.dart';

class UpdateBirthdayBloc
    extends Bloc<UpdateBirthdayEvent, UpdateBirthdayState> {
  UpdateBirthdayBloc(this._personRepository, person, this._settingsRepository)
      : super(UpdateBirthdayState.personModel(person: person)) {
    on<UpdateBirtdayDelete>(_onDeleteTap);
    on<UpdateBirtdayNameChanged>(_onNameChanged);
    on<UpdateBirtdayDateTap>(_onDateTap);
    on<UpdateBirtdayImageTap>(_onImageTap);
    on<UpdateBirthdaySave>(_onSave);
  }

  final AbstractPersonRepository _personRepository;
  final AbstractSettingsRepository _settingsRepository;
  void _onImageTap(
      UpdateBirtdayImageTap event, Emitter<UpdateBirthdayState> emit) async {
    final File? file = await AppImagePickerService.getImageFromGallery();

    emit(state.copyWith(file: file));
  }

  void _onNameChanged(
      UpdateBirtdayNameChanged event, Emitter<UpdateBirthdayState> emit) {
    debugPrint("Name: ${event.name}");
    emit(state.copyWith(name: event.name));
  }

  void _onDeleteTap(
      UpdateBirtdayDelete event, Emitter<UpdateBirthdayState> emit) async {
    final delPerson = await _personRepository.deletePerson(event.id);
    delPerson.fold(
        (failure) => emit(state.copyWith(status: UpdateBirthdayStatus.failure)),
        (result) async {
      ///Cancel scheduling notifications

      await AwesomeNotifications().cancel(event.id);
      debugPrint("Delete Person with ID: ${event.id}");
    });

    emit(state.copyWith(status: UpdateBirthdayStatus.success));
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
      if (state.name != '') {
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
            (result) async {
          //cancel notification
          await AwesomeNotifications().cancel(person.id);
          //scheduling notification
          final notificationInterval =
              await _settingsRepository.getNotificationDay();
          notificationInterval.fold(
              (failure) =>
                  emit(state.copyWith(status: UpdateBirthdayStatus.failure)),
              (result) async {
            final birthday = state.birthdate;
            await NotificationService.scheduleBirthdayNotification(
              id: person.id,
              interval: result,
              birthday: birthday,
            );
          });
        });
        debugPrint("Update Person with id: ${person.id}");
        emit(state.copyWith(status: UpdateBirthdayStatus.success));
      } else {
        emit(state.copyWith(status: UpdateBirthdayStatus.validatorFailure));
        emit(state.copyWith(status: UpdateBirthdayStatus.initial));
      }
    } catch (e) {
      emit(state.copyWith(status: UpdateBirthdayStatus.failure));
    } finally {}
  }
}
