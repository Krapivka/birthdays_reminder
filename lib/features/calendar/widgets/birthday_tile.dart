import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/utils/date_utils/date_utils.dart';
import 'package:birthdays_reminder/features/birthdays_list/bloc/birthdays_list_bloc.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdayTile extends StatelessWidget {
  const BirthdayTile({
    super.key,
    required this.person,
    required this.index,
  });
  final PersonModel person;
  final int index;
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SettingsBloc>();
    final file = File(person.filePath);
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(UpdateBirthdayRoute(personmodel: person));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Card(
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
                    person.birthdate, bloc.state.dateFormat)),
                trailing: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2),
                    ),
                    child: Center(
                        child: Text(
                            DateTimeUtils.getDifferenceCurrentDayBirthDay(
                                person.birthdate)))))),
      ),
    );
  }
}
