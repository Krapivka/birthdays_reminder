import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DateFormatSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор формата даты'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Выберите формат даты:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            DateFormatOption(
              format: 'dd/MM/yyyy',
              isSelected: true, // Здесь можно установить начальное состояние
              onTap: () {
                // Здесь можно обработать выбор формата даты
                // Например, сохранить выбранный формат в настройках приложения.
              },
            ),
            DateFormatOption(
              format: 'MM/dd/yyyy',
              onTap: () {
                // Обработать выбор другого формата
              },
            ),
            // Добавьте другие форматы по аналогии
          ],
        ),
      ),
    );
  }
}

class DateFormatOption extends StatelessWidget {
  final String format;
  final bool isSelected;
  final VoidCallback onTap;

  const DateFormatOption({
    Key? key,
    required this.format,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 10),
            Text(
              format,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
