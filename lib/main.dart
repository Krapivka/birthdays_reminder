import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:birthdays_reminder/core/data/datasources/person_local_data_source.dart';
import 'package:birthdays_reminder/core/data/repositories/person_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'birthdays_reminder_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelGroupKey: "basic_channel_group",
      channelKey: "birthday_notification",
      channelName: "Birthday notification",
      channelDescription: "Test notifications channel",
    ),
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group"),
  ]);

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  final personApi = PersonLocalDataSourceImpl(
      sharedPreferences: await SharedPreferences.getInstance());

  final personRepository = PersonRepositoryImpl(localDataSource: personApi);

  runApp(App(personRepository: personRepository));
}
