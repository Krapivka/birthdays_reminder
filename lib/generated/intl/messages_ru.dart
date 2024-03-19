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

  static String m2(day, hour, minute) =>
      "Уведомлять за ${day} дней в ${hour}:${minute}";

  static String m3(nextAge) => "Исполняется ${nextAge}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutApp": MessageLookupByLibrary.simpleMessage("О приложении"),
        "addBirthday":
            MessageLookupByLibrary.simpleMessage("Добавить день рождения"),
        "addBirthdayButton": MessageLookupByLibrary.simpleMessage("Создать"),
        "appVersionN": m0,
        "authorN": m1,
        "birthdays": MessageLookupByLibrary.simpleMessage("Дни рождения"),
        "birthdaysNotFound":
            MessageLookupByLibrary.simpleMessage("День рождения не найден"),
        "calendar": MessageLookupByLibrary.simpleMessage("Календарь"),
        "chooseDateFormat":
            MessageLookupByLibrary.simpleMessage("Выберите формат даты:"),
        "chooseTheme": MessageLookupByLibrary.simpleMessage("Выбор темы"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Выберите язык:"),
        "darkThemeModeName":
            MessageLookupByLibrary.simpleMessage("Темная тема"),
        "dateFormat": MessageLookupByLibrary.simpleMessage("Формат даты"),
        "daysShouldINotifyAboutBirthdays": MessageLookupByLibrary.simpleMessage(
            "За сколько дней уведомлять о днях рождения?"),
        "emptyBirthdaysList": MessageLookupByLibrary.simpleMessage(
            "Добавьте день рождения, чтобы не забыть поздравить"),
        "emptyDayCalendar": MessageLookupByLibrary.simpleMessage(
            "В этот день нет дней рождения"),
        "enterNameInTextField":
            MessageLookupByLibrary.simpleMessage("Введите имя"),
        "fillInTheRequiredFields":
            MessageLookupByLibrary.simpleMessage("Заполните обязательные поля"),
        "hintTextNameInTextField": MessageLookupByLibrary.simpleMessage("Имя"),
        "hopeMessageAppInInfo": MessageLookupByLibrary.simpleMessage(
            "Мы надеемся, что наше приложение сделает ваши поздравления более организованными и запоминающимися."),
        "info": MessageLookupByLibrary.simpleMessage("Информация"),
        "language": MessageLookupByLibrary.simpleMessage("Язык"),
        "lightThemeModeName":
            MessageLookupByLibrary.simpleMessage("Светлая тема"),
        "notification": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "notifyDayNInAdvanceAtHourNminuteN": m2,
        "purposeMessageAppInInfo": MessageLookupByLibrary.simpleMessage(
            "Приложение предназначено для того, чтобы вы никогда не забывали о днях рождения ваших близких и дорогих людей. С легкостью устанавливайте уведомления, чтобы вовремя поздравить их с праздником!"),
        "receiveNotificationsTime": MessageLookupByLibrary.simpleMessage(
            "В какое время хотите получать уведомления?"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "search": MessageLookupByLibrary.simpleMessage("Поиск"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "systemThemeModeName":
            MessageLookupByLibrary.simpleMessage("Системная тема"),
        "theme": MessageLookupByLibrary.simpleMessage("Тема"),
        "thisIsATestNotificationItsAllRight":
            MessageLookupByLibrary.simpleMessage(
                "Это тестовое уведомление. Всё работает!"),
        "turnsN": m3,
        "updateBirthday": MessageLookupByLibrary.simpleMessage("Обновить"),
        "welcomeMessageInInfo": MessageLookupByLibrary.simpleMessage(
            "Добро пожаловать в наше приложение напоминаний о днях рождения!"),
        "youHaveNotEnteredARequiredField": MessageLookupByLibrary.simpleMessage(
            "You have not entered a required field!")
      };
}
