import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/features/adding_birthday/adding_birthday.dart';
import 'package:birthdays_reminder/features/home/home.dart';
import 'package:birthdays_reminder/features/update_birthday/update_birthday.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
        ),
        AutoRoute(path: '/update_birthday', page: UpdateBirthdayRoute.page),
        AutoRoute(path: '/add_birthday', page: AddingBirthdayRoute.page),
      ];
}
