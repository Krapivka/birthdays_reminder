import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор темы'),
      ),
      body: const Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ThemeOption(
              keyTheme: 'light',
              themeName: 'Светлая тема',
            ),
            ThemeOption(
              keyTheme: 'dark',
              themeName: 'Темная тема',
            )
          ],
        ),
      ),
    );
  }
}

class ThemeOption extends StatelessWidget {
  final String themeName;
  final String keyTheme;
  const ThemeOption({
    required this.themeName,
    required this.keyTheme,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<SettingsBloc>(context).add(SetThemeEvent(keyTheme));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  state.theme == keyTheme
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: state.theme == keyTheme ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  themeName,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
