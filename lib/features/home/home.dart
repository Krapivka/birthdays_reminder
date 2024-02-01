import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/features/adding_birthday/adding_birthday.dart';
import 'package:birthdays_reminder/features/birthdays_list/birthdays_list.dart';
import 'package:birthdays_reminder/features/calendar/calendar.dart';
import 'package:birthdays_reminder/features/home/cubit/home_cubit.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeView(),
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
            AutoRouter.of(context).push(const AddingBirthdayRoute());
          },
          child: const Icon(Icons.add),
        ),
        body: IndexedStack(
          index: selectedTab.index,
          children: const [BirthdaysListPage(), CalendarPage()],
        ));
  }
}
