import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор темы'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ThemeOption(
              themeName: 'Светлая тема',
              //themeData: ThemeData.light(),
            ),
            ThemeOption(
              themeName: 'Темная тема',
              isSelected: true,
              //themeData: ThemeData.dark(),
            )
          ],
        ),
      ),
    );
  }
}

class ThemeOption extends StatelessWidget {
  final String themeName;
  final bool isSelected;

  const ThemeOption({
    Key? key,
    this.isSelected = false,
    required this.themeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              themeName,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
