import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/features/adding_birthday/adding_birthday.dart';
import 'package:birthdays_reminder/features/home/home.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page),
        AutoRoute(path: '/add_birthday', page: AddingBirthdayRoute.page),
      ];
}
