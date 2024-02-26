import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/birthdays_list/birthdays_list.dart';
import 'package:birthdays_reminder/features/birthdays_list/bloc/birthdays_list_bloc.dart';
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
        create: (context) =>
            BirthdaysListBloc(RepositoryProvider.of<PersonRepository>(context)),
        child: HomeView());
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
          leading: IconButton(
              onPressed: () {
                // await NotificationService.showNotification(
                //     title: "Schedule Notification",
                //     body: "Check App, maybe you have birthdays today",
                //     scheduled: true,
                //     interval: 5);
                AutoRouter.of(context).push(const SettingsRoute());
              },
              icon: const Icon(Icons.menu)),
          title: const Text(
            "Birthdays",
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<BirthdaysListBloc, BirthdaysListState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.selectedPersonId.isNotEmpty,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      BlocProvider.of<BirthdaysListBloc>(context)
                          .add(DeletePersonBirthdaysListEvent());
                    },
                  ),
                );
              },
            )
          ],
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
