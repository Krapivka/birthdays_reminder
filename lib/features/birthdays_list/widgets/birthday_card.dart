import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:birthdays_reminder/core/utils/date_utils/date_utils.dart';
import 'package:birthdays_reminder/features/birthdays_list/bloc/birthdays_list_bloc.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({
    super.key,
    required this.person,
    required this.index,
  });
  final PersonModel person;
  final int index;
  @override
  Widget build(BuildContext context) {
    final file = File(person.filePath);
    final bloc = BlocProvider.of<BirthdaysListBloc>(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return InkWell(
            onTap: () {
              if (bloc.state.selectedPersonId.isEmpty) {
                AutoRouter.of(context)
                    .push(UpdateBirthdayRoute(personmodel: person));
              } else {
                bloc.add(TapBirthdayCardEvent(id: person.id));
              }
            },
            // child: Dismissible(
            //   key: UniqueKey(),
            //   background: const Card(
            //     color: Color.fromARGB(255, 253, 253, 253),
            //     child: Icon(Icons.delete),
            //   ),
            //   onDismissed: (direction) {
            //     bloc.add(DeletePersonBirthdaysListEvent(id: person.id));
            //   },

            onLongPress: () {
              bloc.add(LongPressBirthdayCardEvent(id: person.id));
            },
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Card(
                  color: bloc.state.selectedPersonId.contains(person.id)
                      ? const Color.fromARGB(255, 230, 230, 230)
                      : Palette.primary,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: person.filePath == "/"
                            ? const AssetImage("assets/images/avatar.png")
                            : FileImage(file) as ImageProvider,
                      ),
                      title: Text(
                        person.name,
                        maxLines: 1,
                      ),
                      subtitle: Text(DateTimeUtils.formatDate(
                          person.birthdate, state.dateFormat)),
                      trailing: DateTimeUtils.getDifferenceCurrentDayBirthDay(
                                  person.birthdate) !=
                              '0'
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2),
                              ),
                              child: Center(
                                  child: Text(
                                DateTimeUtils.getDifferenceCurrentDayBirthDay(
                                    person.birthdate),
                                style: const TextStyle(fontSize: 12),
                              )))
                          : SizedBox(
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset(
                                  'assets/images/confetti.svg',
                                  semanticsLabel: 'Confetti'),
                            ))),
            ));
      },
    );
  }
}
