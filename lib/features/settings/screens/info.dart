import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/generated/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class InfoPage extends StatelessWidget {
  final String appVersion = '1.0.0';
  final String author = 'KrapStudio';

  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).aboutApp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).appVersionN(appVersion),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).welcomeMessageInInfo,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).purposeMessageAppInInfo,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).hopeMessageAppInInfo,
              style: const TextStyle(fontSize: 16),
            ),

            const Spacer(), // Размещаем автора внизу экрана
            Text(
              S.of(context).authorN(author),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
