import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';

import 'package:birthdays_reminder/core/utils/theme/theme.dart';
import 'package:birthdays_reminder/features/home/cubit/home_cubit.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:birthdays_reminder/generated/l10n.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/services/google_drive/google_drive_service.dart';

late final windowSize;

class App extends StatelessWidget {
  final AbstractPersonRepository personRepository;
  final AbstractSettingsRepository settingsRepository;
  final GoogleDriveService googleDriveService;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  const App(
      {super.key,
      required this.googleDriveService,
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
          RepositoryProvider.value(
            value: googleDriveService,
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
                            context),
                    googleDriveService:
                        RepositoryProvider.of<GoogleDriveService>(context))
                  ..add(const InitializeSettingsEvent()))
          ],
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      if (state.status == SettingsStatus.initial) {
        windowSize = MediaQuery.of(context).size;
      }
      if (state.status == SettingsStatus.success) {
        return MaterialApp.router(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale(state.language),
          debugShowCheckedModeBanner: false,
          title: 'Memo birthday',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state.theme.themeMode,
          routerConfig: _appRouter.config(),
        );
      } else {
        return const Placeholder();
      }
    });
  }
}
