import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class InfoPage extends StatelessWidget {
  final String appVersion = '1.0.0';
  final String author = 'Ваше Имя';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О приложении'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Версия приложения: $appVersion',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Добро пожаловать в наше приложение напоминаний о днях рождения!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Приложение предназначено для того, чтобы вы никогда не забывали о днях рождения ваших близких и дорогих людей. С легкостью устанавливайте уведомления, чтобы вовремя поздравить их с праздником!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Мы надеемся, что наше приложение сделает ваши поздравления более организованными и запоминающимися.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Благодарим вас за использование нашего приложения!',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(), // Размещаем автора внизу экрана
            Text(
              'Автор: $author',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
