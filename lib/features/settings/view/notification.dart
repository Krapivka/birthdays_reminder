import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsNotificationPage extends StatelessWidget {
  const SettingsNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsNotificationPageView();
  }
}

class SettingsNotificationPageView extends StatefulWidget {
  const SettingsNotificationPageView({super.key});

  @override
  State<SettingsNotificationPageView> createState() =>
      _SettingsNotificationPageViewState();
}

class _SettingsNotificationPageViewState
    extends State<SettingsNotificationPageView> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'How many days should I notify about birthdays?',
                style: TextStyle(fontSize: 16),
              ),
            ),
            CupertinoPicker(
              itemExtent: 60,
              onSelectedItemChanged: (index) {},
              children: List.generate(
                  30, (index) => Center(child: Text('${index + 1}'))),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Set the day")),
            ))
          ],
        ),
      ),
    );
  }
}
