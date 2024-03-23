import 'package:birthdays_reminder/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:birthdays_reminder/features/settings/data/models/day_time_notification.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required this.settingsRepository}) : super(SettingsState()) {
    on<InitializeSettingsEvent>(_onInitializeSettingsEvent);
    on<SetNotificationDayTimeEvent>(_onSetNotificationDayEvent);
    on<SetThemeEvent>(_onSetThemeEvent);
    on<SetLanguageEvent>(_onSetLanguageEvent);
    on<SetDateFormatEvent>(_onSetDateFormatEvent);
  }
  final AbstractSettingsRepository settingsRepository;

  void _onInitializeSettingsEvent(
      InitializeSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(
      status: SettingsStatus.loading,
    ));
    final notificationDay = await settingsRepository.getSettingsData();

    notificationDay
        .fold((failure) => emit(state.copyWith(status: SettingsStatus.failure)),
            (result) {
      emit(state.copyWith(
        dayTimeNotification: result.dayTimeNotification,
        language: result.language,
        dateFormat: result.dateFormat,
        theme: result.theme,
        status: SettingsStatus.success,
      ));
    });
  }

  void _onSetNotificationDayEvent(
      SetNotificationDayTimeEvent event, Emitter<SettingsState> emit) async {
    final notificationDay = await settingsRepository
        .setNotificationDayTime(event.dayTimeNotification);
    notificationDay.fold(
        (failure) => emit(state.copyWith(status: SettingsStatus.failure)),
        (result) => emit(
            state.copyWith(dayTimeNotification: event.dayTimeNotification)));
    debugPrint(state.dayTimeNotification.toString());
  }

  void _onSetThemeEvent(
      SetThemeEvent event, Emitter<SettingsState> emit) async {
    final theme = await settingsRepository.setTheme(event.theme);
    theme.fold(
        (failure) => emit(state.copyWith(status: SettingsStatus.failure)),
        (result) => emit(state.copyWith(
            theme: event.theme, status: SettingsStatus.success)));
    debugPrint(state.theme.localization);
  }

  void _onSetLanguageEvent(
      SetLanguageEvent event, Emitter<SettingsState> emit) async {
    final language = await settingsRepository.setLanguage(event.language);
    language.fold(
        (failure) => emit(state.copyWith(status: SettingsStatus.failure)),
        (result) => emit(state.copyWith(language: event.language)));
    debugPrint(state.language);
  }

  void _onSetDateFormatEvent(
      SetDateFormatEvent event, Emitter<SettingsState> emit) async {
    final dateFormat = await settingsRepository.setDateFormat(event.dateFormat);
    dateFormat.fold(
        (failure) => emit(state.copyWith(status: SettingsStatus.failure)),
        (result) => emit(state.copyWith(dateFormat: event.dateFormat)));
    debugPrint(state.dateFormat);
  }

  // void _onSetLanguageEvent(
  //     SetLanguageEvent event, Emitter<SettingsState> emit) async {
  //   final language = await settingsRepository.setLanguage(event.language);
  //   language.fold(
  //       (failure) => emit(state.copyWith(status: SettingsStatus.failure)),
  //       (result) => emit(state.copyWith(theme: event.language)));
  //   debugPrint(state.theme);
  // }
}
