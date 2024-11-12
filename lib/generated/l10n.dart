// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Date format`
  String get dateFormat {
    return Intl.message(
      'Date format',
      name: 'dateFormat',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Select themes`
  String get chooseTheme {
    return Intl.message(
      'Select themes',
      name: 'chooseTheme',
      desc: '',
      args: [],
    );
  }

  /// `System theme`
  String get systemThemeModeName {
    return Intl.message(
      'System theme',
      name: 'systemThemeModeName',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get lightThemeModeName {
    return Intl.message(
      'Light theme',
      name: 'lightThemeModeName',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get darkThemeModeName {
    return Intl.message(
      'Dark theme',
      name: 'darkThemeModeName',
      desc: '',
      args: [],
    );
  }

  /// `How many days should notify about birthdays?`
  String get daysShouldINotifyAboutBirthdays {
    return Intl.message(
      'How many days should notify about birthdays?',
      name: 'daysShouldINotifyAboutBirthdays',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Select a language:`
  String get chooseYourLanguage {
    return Intl.message(
      'Select a language:',
      name: 'chooseYourLanguage',
      desc: '',
      args: [],
    );
  }

  /// `About app`
  String get aboutApp {
    return Intl.message(
      'About app',
      name: 'aboutApp',
      desc: '',
      args: [],
    );
  }

  /// `Application Version: {appVersion}`
  String appVersionN(Object appVersion) {
    return Intl.message(
      'Application Version: $appVersion',
      name: 'appVersionN',
      desc: '',
      args: [appVersion],
    );
  }

  /// `Author: {author}`
  String authorN(Object author) {
    return Intl.message(
      'Author: $author',
      name: 'authorN',
      desc: '',
      args: [author],
    );
  }

  /// `Welcome to our birthday reminder app!`
  String get welcomeMessageInInfo {
    return Intl.message(
      'Welcome to our birthday reminder app!',
      name: 'welcomeMessageInInfo',
      desc: '',
      args: [],
    );
  }

  /// `The application is designed so that you never forget about the birthdays of your loved ones and dear ones. Easily set notifications to wish them a happy holiday on time!`
  String get purposeMessageAppInInfo {
    return Intl.message(
      'The application is designed so that you never forget about the birthdays of your loved ones and dear ones. Easily set notifications to wish them a happy holiday on time!',
      name: 'purposeMessageAppInInfo',
      desc: '',
      args: [],
    );
  }

  /// `We hope that our application will make your greetings more organized and memorable.`
  String get hopeMessageAppInInfo {
    return Intl.message(
      'We hope that our application will make your greetings more organized and memorable.',
      name: 'hopeMessageAppInInfo',
      desc: '',
      args: [],
    );
  }

  /// `Select the date format:`
  String get chooseDateFormat {
    return Intl.message(
      'Select the date format:',
      name: 'chooseDateFormat',
      desc: '',
      args: [],
    );
  }

  /// `There are no birthdays on this day`
  String get emptyDayCalendar {
    return Intl.message(
      'There are no birthdays on this day',
      name: 'emptyDayCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Add a birthday so you don't forget to congratulate`
  String get emptyBirthdaysList {
    return Intl.message(
      'Add a birthday so you don\'t forget to congratulate',
      name: 'emptyBirthdaysList',
      desc: '',
      args: [],
    );
  }

  /// `The birthday was not found`
  String get birthdaysNotFound {
    return Intl.message(
      'The birthday was not found',
      name: 'birthdaysNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enterNameInTextField {
    return Intl.message(
      'Enter name',
      name: 'enterNameInTextField',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get hintTextNameInTextField {
    return Intl.message(
      'Name',
      name: 'hintTextNameInTextField',
      desc: '',
      args: [],
    );
  }

  /// `Add birthday`
  String get addBirthday {
    return Intl.message(
      'Add birthday',
      name: 'addBirthday',
      desc: '',
      args: [],
    );
  }

  /// `Add birthday`
  String get addBirthdayButton {
    return Intl.message(
      'Add birthday',
      name: 'addBirthdayButton',
      desc: '',
      args: [],
    );
  }

  /// `Update birthday`
  String get updateBirthday {
    return Intl.message(
      'Update birthday',
      name: 'updateBirthday',
      desc: '',
      args: [],
    );
  }

  /// `What time do you want to receive notifications?`
  String get receiveNotificationsTime {
    return Intl.message(
      'What time do you want to receive notifications?',
      name: 'receiveNotificationsTime',
      desc: '',
      args: [],
    );
  }

  /// `notify {day} days in advance at {hour}:{minute}`
  String notifyDayNInAdvanceAtHourNminuteN(
      Object day, Object hour, Object minute) {
    return Intl.message(
      'notify $day days in advance at $hour:$minute',
      name: 'notifyDayNInAdvanceAtHourNminuteN',
      desc: '',
      args: [day, hour, minute],
    );
  }

  /// `You have not entered a required field!`
  String get youHaveNotEnteredARequiredField {
    return Intl.message(
      'You have not entered a required field!',
      name: 'youHaveNotEnteredARequiredField',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the required fields`
  String get fillInTheRequiredFields {
    return Intl.message(
      'Fill in the required fields',
      name: 'fillInTheRequiredFields',
      desc: '',
      args: [],
    );
  }

  /// `This is a test notification. It's all right!`
  String get thisIsATestNotificationItsAllRight {
    return Intl.message(
      'This is a test notification. It\'s all right!',
      name: 'thisIsATestNotificationItsAllRight',
      desc: '',
      args: [],
    );
  }

  /// `Birthdays`
  String get birthdays {
    return Intl.message(
      'Birthdays',
      name: 'birthdays',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Turns {nextAge}`
  String turnsN(Object nextAge) {
    return Intl.message(
      'Turns $nextAge',
      name: 'turnsN',
      desc: '',
      args: [nextAge],
    );
  }

  /// `Log in to Google Drive`
  String get logInToGoogleDrive {
    return Intl.message(
      'Log in to Google Drive',
      name: 'logInToGoogleDrive',
      desc: '',
      args: [],
    );
  }

  /// `Log out of Google Drive`
  String get logOutOfGoogleDrive {
    return Intl.message(
      'Log out of Google Drive',
      name: 'logOutOfGoogleDrive',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backup {
    return Intl.message(
      'Backup',
      name: 'backup',
      desc: '',
      args: [],
    );
  }

  /// `Recovery`
  String get recovery {
    return Intl.message(
      'Recovery',
      name: 'recovery',
      desc: '',
      args: [],
    );
  }

  /// `Google Drive`
  String get googleDrive {
    return Intl.message(
      'Google Drive',
      name: 'googleDrive',
      desc: '',
      args: [],
    );
  }

  /// `Error: {errorMessage}`
  String errorN(Object errorMessage) {
    return Intl.message(
      'Error: $errorMessage',
      name: 'errorN',
      desc: '',
      args: [errorMessage],
    );
  }

  /// `Backup completed successfully`
  String get backupCompletedSuccessfully {
    return Intl.message(
      'Backup completed successfully',
      name: 'backupCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Restore completed successfully`
  String get restoreCompletedSuccessfully {
    return Intl.message(
      'Restore completed successfully',
      name: 'restoreCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Logged out successfully`
  String get loggedOutSuccessfully {
    return Intl.message(
      'Logged out successfully',
      name: 'loggedOutSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Backup on Google Drive`
  String get backupOnGoogleDrive {
    return Intl.message(
      'Backup on Google Drive',
      name: 'backupOnGoogleDrive',
      desc: '',
      args: [],
    );
  }

  /// `Do not lose data when changing your device`
  String get doNotLoseDataWhenChangingYourDevice {
    return Intl.message(
      'Do not lose data when changing your device',
      name: 'doNotLoseDataWhenChangingYourDevice',
      desc: '',
      args: [],
    );
  }

  /// `Create a backup`
  String get createABackup {
    return Intl.message(
      'Create a backup',
      name: 'createABackup',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
