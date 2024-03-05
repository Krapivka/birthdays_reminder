import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:birthdays_reminder/generated/l10n.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsPageView();
  }
}

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).settings),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.notifications_on_outlined),
                title: Text(S.of(context).notification),
                subtitle: Text(S.of(context).notifyDayNInAdvanceAtHourNminuteN(
                    state.dayTimeNotification.day,
                    state.dayTimeNotification.hour,
                    state.dayTimeNotification.minute == 0
                        ? "00"
                        : state.dayTimeNotification.minute)),
                onTap: () {
                  AutoRouter.of(context)
                      .push(const SettingsNotificationRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.language_outlined),
                title: Text(S.of(context).language),
                subtitle: Text(state.language),
                onTap: () {
                  AutoRouter.of(context).push(const LanguageSelectionRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.date_range_outlined),
                title: Text(S.of(context).dateFormat),
                subtitle: Text(state.dateFormat),
                onTap: () {
                  AutoRouter.of(context).push(const DateFormatSelectionRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.color_lens_outlined),
                title: Text(S.of(context).theme),
                subtitle: Text(state.theme.localization),
                onTap: () {
                  AutoRouter.of(context).push(const ThemeSelectionRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(S.of(context).info),
                onTap: () {
                  AutoRouter.of(context).push(const InfoRoute());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
