import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DateFormatSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор формата даты'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Выберите формат даты:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            DateFormatOption(
              dateFormat: 'dd/MM/yyyy',
            ),
            DateFormatOption(
              dateFormat: 'MM/dd/yyyy',
            ),
          ],
        ),
      ),
    );
  }
}

class DateFormatOption extends StatelessWidget {
  final String dateFormat;

  const DateFormatOption({
    super.key,
    required this.dateFormat,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => BlocProvider.of<SettingsBloc>(context)
              .add(SetDateFormatEvent(dateFormat)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  state.dateFormat == dateFormat
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: state.dateFormat == dateFormat
                      ? Colors.green
                      : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  dateFormat,
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
