import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/core/services/ads/yandex_ads/banner/banner_ad.dart';
import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:birthdays_reminder/features/birthdays_list/bloc/birthdays_list_bloc.dart';
import 'package:birthdays_reminder/features/calendar/bloc/bloc/calendar_bloc.dart';
import 'package:birthdays_reminder/features/calendar/widgets/birthday_tile.dart';
import 'package:birthdays_reminder/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(
          RepositoryProvider.of<AbstractPersonRepository>(context)),
      child: const CalendarPageView(),
    );
  }
}

class CalendarPageView extends StatefulWidget {
  const CalendarPageView({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    return BlocListener<BirthdaysListBloc, BirthdaysListState>(
      listener: (context, state) {
        if (state.birthdayListStatus ==
            BirthdaysListStatus.selectedBirthdaysDeleted) {
          BlocProvider.of<CalendarBloc>(context)
              .add(const LoadBirthdaysCalendar());
          BlocProvider.of<CalendarBloc>(context)
              .add(CalendarDateTap(_focusedDay));
        }
      },
      child:
          BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const BannerAdWidget(
                isSticky: true,
              ),
              TableCalendar<PersonModel>(
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
                    markerDecoration: BoxDecoration(
                        color: Palette.secondaryAccent, shape: BoxShape.circle),
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
                        color: Palette.primaryAccent, shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                        color: Palette.secondaryAccent,
                        shape: BoxShape.circle)),
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
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: BlocBuilder<CalendarBloc, CalendarState>(
                  builder: (context, state) {
                    if (state.birthdaysInSelectedDay.isEmpty) {
                      return Center(
                        child: Text(S.of(context).emptyDayCalendar),
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
            ],
          ),
        );
      }),
    );
  }
}
