import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/services/notification/notification_service.dart';
import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:birthdays_reminder/features/settings/data/models/day_time_notification.dart';
import 'package:birthdays_reminder/generated/l10n.dart';
import 'package:birthdays_reminder/router/router.dart';
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
    DayTimeNotification dayTimeNotification =
        BlocProvider.of<SettingsBloc>(context).state.dayTimeNotification;
    int notificationDay = dayTimeNotification.day;
    int notificationHour = dayTimeNotification.hour;
    int notificationMinute = dayTimeNotification.minute;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).notification),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                NotificationService.showTestNotification(
                    S.of(context).thisIsATestNotificationItsAllRight);
              },
              icon: const Icon(Icons.notification_important))
        ],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: SizedBox(
                height: 180,
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: notificationDay - 1),
                  looping: true,
                  itemExtent: 60,
                  onSelectedItemChanged: (index) {
                    notificationDay = index + 1;
                  },
                  children: List.generate(
                      30, (index) => Center(child: Text('${index + 1}'))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).receiveNotificationsTime,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(0, 0, notificationDay,
                      notificationHour, notificationMinute),
                  itemExtent: 60,
                  use24hFormat: true,
                  onDateTimeChanged: (dateTime) {
                    notificationHour = dateTime.hour;
                    notificationMinute = dateTime.minute;
                  }),
            ),
            Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _ButtonAddBirthday(
                      onTap: () {
                        BlocProvider.of<SettingsBloc>(context).add(
                            SetNotificationDayTimeEvent(DayTimeNotification(
                                day: notificationDay,
                                hour: notificationHour,
                                minute: notificationMinute)));
                        AutoRouter.of(context).pushAndPopUntil(
                            const HomeRoute(),
                            predicate: (Route<dynamic> route) => false);
                      },
                    )))
          ],
        ),
      ),
    );
  }
}

class _ButtonAddBirthday extends StatelessWidget {
  const _ButtonAddBirthday({
    required this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Palette.primaryAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            S.of(context).save,
            style: const TextStyle(color: Palette.secondaryLight),
          ),
        ),
      ),
    );
  }
}
