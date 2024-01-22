import 'package:birthdays_reminder/features/birthdays_list/widgets/birthday_card.dart';
import 'package:flutter/material.dart';

class BirthdaysListPage extends StatelessWidget {
  const BirthdaysListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BirthdaysListView();
  }
}

class BirthdaysListView extends StatelessWidget {
  const BirthdaysListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            BirthdayCard(),
            BirthdayCard(),
            BirthdayCard(),
          ],
        ),
      ),
    );
  }
}
