import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Choose your language:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            LanguageOption(
              keyLang: 'en',
              language: 'English',
            ),
            LanguageOption(
              keyLang: 'ru',
              language: 'Русский',
            ),
            // Добавьте другие языки по аналогии
          ],
        ),
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String keyLang;

  final String language;

  const LanguageOption({
    super.key,
    required this.language,
    required this.keyLang,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<SettingsBloc>(context)
                .add(SetLanguageEvent(keyLang));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  state.language == keyLang
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: state.language == keyLang ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  language,
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
