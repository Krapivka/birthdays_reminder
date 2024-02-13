import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';

import 'package:birthdays_reminder/core/utils/theme/theme.dart';
import 'package:birthdays_reminder/features/home/cubit/home_cubit.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final PersonRepository personRepository;
  final AbstractSettingsRepository settingsRepository;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  const App(
      {super.key,
      required this.personRepository,
      required this.settingsRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: personRepository,
          ),
          RepositoryProvider.value(
            value: settingsRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeCubit(),
            ),
            BlocProvider(
                create: (context) => SettingsBloc(
                    settingsRepository:
                        RepositoryProvider.of<AbstractSettingsRepository>(
                            context))
                  ..add(const InitializeSettingsEvent()))
          ],
          child: AppView(),
        ));
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
