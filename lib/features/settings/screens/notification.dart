import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:birthdays_reminder/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsNotificationPage extends StatelessWidget {
  const SettingsNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsNotificationPageView();
  }
}

class SettingsNotificationPageView extends StatelessWidget {
  const SettingsNotificationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    int notificationDay = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).notification),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).daysShouldINotifyAboutBirthdays,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            CupertinoPicker(
              itemExtent: 60,
              onSelectedItemChanged: (index) {
                notificationDay = index + 1;
              },
              children: List.generate(
                  30, (index) => Center(child: Text('${index + 1}'))),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SettingsBloc>(context)
                        .add(SetNotificationDayEvent(notificationDay));
                  },
                  child: Text(S.of(context).save)),
            ))
          ],
        ),
      ),
    );
  }
}
