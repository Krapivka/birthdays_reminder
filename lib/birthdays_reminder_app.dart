import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';

import 'package:birthdays_reminder/core/utils/theme/theme.dart';
import 'package:birthdays_reminder/notification_controller.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  final PersonRepository personRepository;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  const App({super.key, required this.personRepository});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.personRepository,
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({
    super.key,
  });
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Birthdays-reminder',
      theme: theme,
      routerConfig: _appRouter.config(),
    );
  }
}
