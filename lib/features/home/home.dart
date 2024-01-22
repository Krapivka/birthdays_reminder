import 'package:birthdays_reminder/features/birthdays_list/birthdays_list.dart';
import 'package:birthdays_reminder/features/calendar/calendar.dart';
import 'package:birthdays_reminder/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Birthdays",
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedTab.index,
          onDestinationSelected: (index) {
            context.read<HomeCubit>().setTab(index);
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Birthdays',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('add_birthday');
          },
          child: Icon(Icons.add),
        ),
        body: IndexedStack(
          index: selectedTab.index,
          children: const [BirthdaysListPage(), CalendarPage()],
        ));
  }
}
