import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Choose your language:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            LanguageOption(
              language: 'English',
              isSelected: true, // Здесь можно установить начальное состояние
              onTap: () {
                // Здесь можно обработать выбор языка
                // Например, сохранить выбранный язык в настройках приложения.
              },
            ),
            LanguageOption(
              language: 'Русский',
              onTap: () {
                // Обработать выбор другого языка
              },
            ),
            // Добавьте другие языки по аналогии
          ],
        ),
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOption({
    Key? key,
    required this.language,
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
              language,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
