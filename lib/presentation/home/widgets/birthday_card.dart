import 'package:flutter/material.dart';

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                  'https://www.sunhome.ru/i/wallpapers/89/girls-v118.orig.jpg'),
            ),
            title: Text('Ленок'),
            subtitle: Text('Исполняется 23'),
            trailing: Container(
                height: 30,
                width: 30,
                child: Center(child: Text("354")),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2),
                ))));
  }
}
