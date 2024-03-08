import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:birthdays_reminder/birthdays_reminder_app.dart';
import 'package:birthdays_reminder/features/home/home.dart';
import 'package:flutter/material.dart';

class NotificationService {
  ///Initialize Notification Channels for our app.
  ///Is notification allowed?
  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "birthday_notification",
        channelName: "Birthday notification",
        channelDescription:
            "This channel notification users about nearby birthday",
        defaultColor: const Color.fromARGB(255, 192, 125, 166),
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        onlyAlertOnce: true,
        playSound: true,
        criticalAlerts: true,
      ),
    ], channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: "high_importance_channel_group",
          channelGroupName: "High Importance Group"),
    ]);

    bool isAllowedToSendNotification =
        await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowedToSendNotification) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }

    AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod);
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationCreatedMethod");
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationDisplayedMethod");
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("onDismissActionReceivedMethod");
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    debugPrint("onDismissActionReceivedMethod");
    //
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      App.navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => const HomePage()));
    }
  }

  static Future<void> scheduleBirthdayNotification(
      {required int id,
      required int interval,
      required DateTime birthday}) async {
    const String title = "Memo birthay";
    const String body =
        "My birthday is coming soon. Come in and check who should prepare the gifts.";
    DateTime firstNotificationTime =
        DateTime(birthday.year, birthday.month, birthday.day, 11)
            .subtract(Duration(days: interval));
    DateTime secondNotificationTime =
        DateTime(birthday.year, birthday.month, birthday.day, 11);
    await showScheduleNotification(
        id: id, title: title, body: body, scheduleTime: firstNotificationTime);
    await showScheduleNotification(
        id: id, title: title, body: body, scheduleTime: secondNotificationTime);
  }

  ///The basic method for creating notification
  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: "birthday_notification",
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true)
          : null,
    );
  }

  static Future<void> showScheduleNotification({
    required final int id,
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    // final bool scheduled = false,
    required final DateTime scheduleTime,
  }) async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    //assert(!scheduled || (scheduled && interval != null));

    final notificationCalendar = NotificationCalendar(
        timeZone: localTimeZone,
        month: scheduleTime.month,
        day: scheduleTime.day,
        hour: 11,
        minute: 0,
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: false);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: "birthday_notification",
        title: title,
        body: body,
        wakeUpScreen: true,
        category: NotificationCategory.Alarm,
        notificationLayout: notificationLayout,
        bigPicture: bigPicture,
        payload: payload,
        autoDismissible: false,
      ),
      schedule: notificationCalendar,
    );
    debugPrint(
        "Id: $id Your local time zone is $localTimeZone. The notification will be triggered at this time: ${notificationCalendar.year}-${notificationCalendar.month}-${notificationCalendar.day}-${notificationCalendar.hour}-${notificationCalendar.minute}");
  }
}
