import 'package:birthdays_reminder/presentation/home/widgets/birthday_card.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
