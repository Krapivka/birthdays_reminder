import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/features/adding_birthday/adding_birthday.dart';
import 'package:birthdays_reminder/features/home/home.dart';
import 'package:birthdays_reminder/features/update_birthday/update_birthday.dart';
import 'package:flutter/material.dart';
import 'package:birthdays_reminder/features/settings/view/settings_list.dart';
import 'package:birthdays_reminder/features/settings/view/notification.dart';
import 'package:birthdays_reminder/features/settings/view/language_selection.dart';
import 'package:birthdays_reminder/features/settings/view/data_format_selection.dart';
import 'package:birthdays_reminder/features/settings/view/info.dart';
import 'package:birthdays_reminder/features/settings/view/theme_selection.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page),
        AutoRoute(path: '/update_birthday', page: UpdateBirthdayRoute.page),
        AutoRoute(path: '/add_birthday', page: AddingBirthdayRoute.page),
        AutoRoute(path: '/settings_list', page: SettingsRoute.page),
        AutoRoute(
            path: '/settings/notification',
            page: SettingsNotificationRoute.page),
        AutoRoute(
            path: '/settings/language_selection',
            page: LanguageSelectionRoute.page),
        AutoRoute(
            path: '/settings/data_format_selection',
            page: DateFormatSelectionRoute.page),
        AutoRoute(path: '/settings/info', page: InfoRoute.page),
        AutoRoute(
            path: '/settings/theme_selection', page: ThemeSelectionRoute.page),
      ];
}
