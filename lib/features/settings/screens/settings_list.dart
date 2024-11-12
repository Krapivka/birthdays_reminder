import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/utils/components/action_button.dart';
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
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.status == SettingsStatus.login) {
          AutoRouter.of(context).push(const BackupRestoreRoute());
        }
      },
      builder: (context, state) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(S.of(context).settings),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<SettingsBloc>(context)
                          .add(GoogleDriveLogin());
                    },
                    child: Container(
                      height: 155,
                      margin: const EdgeInsets.all(14.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Stack(
                        children: [
                          Transform.translate(
                            offset: const Offset(220, -30),
                            child: Transform.rotate(
                                angle: 50,
                                child: Image.asset(
                                    'assets/images/Google_Drive_Logo.png')),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    S.of(context).backupOnGoogleDrive,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(S
                                  .of(context)
                                  .doNotLoseDataWhenChangingYourDevice),
                              const SizedBox(
                                height: 17,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ActionButton(
                                    text: S.of(context).createABackup),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(14, 0, 14, 5),
                    // padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.notifications_on_outlined),
                          title: Text(S.of(context).notification),
                          subtitle: Text(S
                              .of(context)
                              .notifyDayNInAdvanceAtHourNminuteN(
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
                            AutoRouter.of(context)
                                .push(const LanguageSelectionRoute());
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.date_range_outlined),
                          title: Text(S.of(context).dateFormat),
                          subtitle: Text(state.dateFormat),
                          onTap: () {
                            AutoRouter.of(context)
                                .push(const DateFormatSelectionRoute());
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.color_lens_outlined),
                          title: Text(S.of(context).theme),
                          subtitle: Text(state.theme.localization),
                          onTap: () {
                            AutoRouter.of(context)
                                .push(const ThemeSelectionRoute());
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: Text(S.of(context).info),
                          onTap: () {
                            AutoRouter.of(context).push(InfoRoute());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
