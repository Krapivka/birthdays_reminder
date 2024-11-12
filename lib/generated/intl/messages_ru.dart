// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(appVersion) => "Версия приложения: ${appVersion}";

  static String m1(author) => "Автор: ${author}";

  static String m2(errorMessage) => "Error: ${errorMessage}";

  static String m3(day, hour, minute) =>
      "Уведомлять за ${day} дней в ${hour}:${minute}";

  static String m4(nextAge) => "Исполняется ${nextAge}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutApp": MessageLookupByLibrary.simpleMessage("О приложении"),
        "addBirthday":
            MessageLookupByLibrary.simpleMessage("Добавить день рождения"),
        "addBirthdayButton": MessageLookupByLibrary.simpleMessage("Создать"),
        "appVersionN": m0,
        "authorN": m1,
        "backup": MessageLookupByLibrary.simpleMessage("Backup"),
        "backupCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Backup completed successfully"),
        "backupOnGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Backup on Google Drive"),
        "birthdays": MessageLookupByLibrary.simpleMessage("Дни рождения"),
        "birthdaysNotFound":
            MessageLookupByLibrary.simpleMessage("День рождения не найден"),
        "calendar": MessageLookupByLibrary.simpleMessage("Календарь"),
        "chooseDateFormat":
            MessageLookupByLibrary.simpleMessage("Выберите формат даты:"),
        "chooseTheme": MessageLookupByLibrary.simpleMessage("Выбор темы"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Выберите язык:"),
        "createABackup":
            MessageLookupByLibrary.simpleMessage("Create a backup"),
        "darkThemeModeName":
            MessageLookupByLibrary.simpleMessage("Темная тема"),
        "dateFormat": MessageLookupByLibrary.simpleMessage("Формат даты"),
        "daysShouldINotifyAboutBirthdays": MessageLookupByLibrary.simpleMessage(
            "За сколько дней уведомлять о днях рождения?"),
        "doNotLoseDataWhenChangingYourDevice":
            MessageLookupByLibrary.simpleMessage(
                "Do not lose data when changing your device"),
        "emptyBirthdaysList": MessageLookupByLibrary.simpleMessage(
            "Добавьте день рождения, чтобы не забыть поздравить"),
        "emptyDayCalendar": MessageLookupByLibrary.simpleMessage(
            "В этот день нет дней рождения"),
        "enterNameInTextField":
            MessageLookupByLibrary.simpleMessage("Введите имя"),
        "errorN": m2,
        "fillInTheRequiredFields":
            MessageLookupByLibrary.simpleMessage("Заполните обязательные поля"),
        "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
        "hintTextNameInTextField": MessageLookupByLibrary.simpleMessage("Имя"),
        "hopeMessageAppInInfo": MessageLookupByLibrary.simpleMessage(
            "Мы надеемся, что наше приложение сделает ваши поздравления более организованными и запоминающимися."),
        "info": MessageLookupByLibrary.simpleMessage("Информация"),
        "language": MessageLookupByLibrary.simpleMessage("Язык"),
        "lightThemeModeName":
            MessageLookupByLibrary.simpleMessage("Светлая тема"),
        "logInToGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Log in to Google Drive"),
        "logOutOfGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Log out of Google Drive"),
        "loggedOutSuccessfully":
            MessageLookupByLibrary.simpleMessage("Logged out successfully"),
        "notification": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "notifyDayNInAdvanceAtHourNminuteN": m3,
        "purposeMessageAppInInfo": MessageLookupByLibrary.simpleMessage(
            "Приложение предназначено для того, чтобы вы никогда не забывали о днях рождения ваших близких и дорогих людей. С легкостью устанавливайте уведомления, чтобы вовремя поздравить их с праздником!"),
        "receiveNotificationsTime": MessageLookupByLibrary.simpleMessage(
            "В какое время хотите получать уведомления?"),
        "recovery": MessageLookupByLibrary.simpleMessage("Recovery"),
        "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Restore completed successfully"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "search": MessageLookupByLibrary.simpleMessage("Поиск"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "systemThemeModeName":
            MessageLookupByLibrary.simpleMessage("Системная тема"),
        "theme": MessageLookupByLibrary.simpleMessage("Тема"),
        "thisIsATestNotificationItsAllRight":
            MessageLookupByLibrary.simpleMessage(
                "Это тестовое уведомление. Всё работает!"),
        "turnsN": m4,
        "updateBirthday": MessageLookupByLibrary.simpleMessage("Обновить"),
        "welcomeMessageInInfo": MessageLookupByLibrary.simpleMessage(
            "Добро пожаловать в наше приложение напоминаний о днях рождения!"),
        "youHaveNotEnteredARequiredField": MessageLookupByLibrary.simpleMessage(
            "Вы не ввели данные в обязательное для заполнения поле!")
      };
}
