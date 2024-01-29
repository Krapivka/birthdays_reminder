import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/utils/datetime.dart';
import 'package:flutter/material.dart';

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({
    super.key,
    required this.person,
  });
  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: const CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                  'https://www.sunhome.ru/i/wallpapers/89/girls-v118.orig.jpg'),
            ),
            title: Text(person.name),
            subtitle: Text(DateTimeUtils().formatDate(person.birthdate)),
            trailing: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2),
                ),
                child: Center(
                    child: Text(DateTimeUtils()
                        .getDifferenceCurrentDayBirthDay(person.birthdate))))));
  }
}
