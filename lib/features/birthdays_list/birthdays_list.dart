import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/birthdays_list/bloc/birthdays_list_bloc.dart';
import 'package:birthdays_reminder/features/birthdays_list/widgets/birthday_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdaysListPage extends StatelessWidget {
  const BirthdaysListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BirthdaysListBloc(RepositoryProvider.of<PersonRepository>(context)),
      child: BirthdaysListView(),
    );
  }
}

class BirthdaysListView extends StatelessWidget {
  const BirthdaysListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BirthdaysListBloc>(context)
        .add(const LoadBirthdaysListEvent());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<BirthdaysListBloc, BirthdaysListState>(
          builder: (context, state) {
            if (state is BirthdaysListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BirthdaysListLoaded) {
              final List<PersonModel> persons = state.listPersonModel;

              return ListView.builder(
                itemCount: persons.length,
                itemBuilder: (context, index) =>
                    BirthdayCard(person: persons[index]),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
