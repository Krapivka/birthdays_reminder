import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/services/ads/yandex_ads/banner/banner_ad.dart';
import 'package:birthdays_reminder/features/birthdays_list/bloc/birthdays_list_bloc.dart';
import 'package:birthdays_reminder/features/birthdays_list/widgets/birthday_card.dart';
import 'package:birthdays_reminder/features/birthdays_list/widgets/birthday_search.dart';
import 'package:birthdays_reminder/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdaysListPage extends StatelessWidget {
  const BirthdaysListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BirthdaysListView();
  }
}

class BirthdaysListView extends StatefulWidget {
  const BirthdaysListView({
    super.key,
  });

  @override
  State<BirthdaysListView> createState() => _BirthdaysListViewState();
}

class _BirthdaysListViewState extends State<BirthdaysListView> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BirthdaysListBloc>(context);
    bloc.add(const LoadBirthdaysListEvent());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: [
            const BannerAdWidget(
              isSticky: true,
            ),
            const BirthdaySearch(),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: BlocBuilder<BirthdaysListBloc, BirthdaysListState>(
                    builder: (context, state) {
                  if (state.birthdayListStatus == BirthdaysListStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.birthdayListStatus == BirthdaysListStatus.loaded) {
                    final List<PersonModel> persons = state.listPersonModel;
                    if (persons.isNotEmpty) {
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: persons.length,
                        itemBuilder: (context, index) =>
                            BirthdayCard(index: index, person: persons[index]),
                      );
                    } else {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Align(
                          child: Text(
                            S.of(context).emptyBirthdaysList,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ));
                    }
                  }
                  if (state.birthdayListStatus ==
                      BirthdaysListStatus.searchLoaded) {
                    final List<PersonModel> persons =
                        state.sortedListPersonModel;

                    if (persons.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: persons.length,
                        itemBuilder: (context, index) =>
                            BirthdayCard(index: index, person: persons[index]),
                      );
                    } else {
                      return Center(
                          child: Text(
                        S.of(context).birthdaysNotFound,
                      ));
                    }
                  }
                  return const SizedBox();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
