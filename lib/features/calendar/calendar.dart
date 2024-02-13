import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/birthdays_list/widgets/birthday_card.dart';
import 'package:birthdays_reminder/features/calendar/bloc/bloc/calendar_bloc.dart';
import 'package:birthdays_reminder/features/calendar/widgets/birthday_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CalendarBloc(RepositoryProvider.of<PersonRepository>(context)),
      child: CalendarPageView(),
    );
  }
}

class CalendarPageView extends StatefulWidget {
  @override
  _CalendarPageViewState createState() => _CalendarPageViewState();
}

class _CalendarPageViewState extends State<CalendarPageView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    BlocProvider.of<CalendarBloc>(context).add(const LoadBirthdaysCalendar());
    BlocProvider.of<CalendarBloc>(context).add(CalendarDateTap(_focusedDay));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final bloc = BlocProvider.of<CalendarBloc>(context);
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      bloc.add(CalendarDateTap(selectedDay));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            return TableCalendar<PersonModel>(
              firstDay: state.firstDay,
              lastDay: state.lastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: (day) {
                return state.birthdays[day] ?? [];
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            );
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                if (state.birthdaysInSelectedDay.isEmpty) {
                  return const Center(
                    child: Text('В этот день нет дней рождения'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.birthdaysInSelectedDay.length,
                  itemBuilder: (context, index) => BirthdayTile(
                      index: index,
                      person: state.birthdaysInSelectedDay[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
