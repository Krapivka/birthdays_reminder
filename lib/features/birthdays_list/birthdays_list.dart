import 'package:auto_route/annotations.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/adding_birthday/bloc/adding_birthday_bloc.dart';
import 'package:birthdays_reminder/features/birthdays_list/bloc/birthdays_list_bloc.dart';
import 'package:birthdays_reminder/features/birthdays_list/widgets/birthday_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    var _controller = TextEditingController();
    final bloc = BlocProvider.of<BirthdaysListBloc>(context);
    bloc.add(const LoadBirthdaysListEvent());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  // readOnly: readOnly,
                  // showCursor: showCursor,
                  // enableInteractiveSelection: false,
                  onChanged: (value) {
                    bloc.add(SearchBirthdaysListEvent(query: value));
                  },
                  controller: _controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _controller.clear();
                          bloc.add(const LoadBirthdaysListEvent());
                        },
                        icon: const Icon(Icons.clear)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    //     labelText: labelText,
                    hintText: "Search",
                    //   ),
                    //   onTap: onTap,
                    // ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
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
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: persons.length,
                      itemBuilder: (context, index) =>
                          BirthdayCard(index: index, person: persons[index]),
                    );
                  }
                  if (state is SearchBirthdaysListLoaded) {
                    final List<PersonModel> persons =
                        state.sortedListPersonModel;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: persons.length,
                      itemBuilder: (context, index) =>
                          BirthdayCard(index: index, person: persons[index]),
                    );
                  }
                  return const SizedBox();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
