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

class BirthdayTile extends StatefulWidget {
  const BirthdayTile({
    super.key,
    required this.person,
    required this.index,
  });
  final PersonModel person;
  final int index;

  @override
  State<BirthdayTile> createState() => _BirthdayTileState();
}

class _BirthdayTileState extends State<BirthdayTile> {
  bool _visible = false;

  void animate() async {
    await Future.delayed(const Duration(milliseconds: 300)).then((value) {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SettingsBloc>();
    animate();
    final file = File(widget.person.filePath);
    return AnimatedOpacity(
        //TODO: animate widget
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),

              onTap: () {
                AutoRouter.of(context)
                    .push(UpdateBirthdayRoute(personmodel: widget.person));
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

              child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: widget.person.filePath == "/"
                            ? const AssetImage("assets/images/avatar.png")
                            : FileImage(file) as ImageProvider,
                      ),
                      title: Text(
                        widget.person.name,
                        maxLines: 1,
                      ),
                      subtitle: Text(DateTimeUtils.formatDate(
                          widget.person.birthdate, bloc.state.dateFormat)),
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
                                      widget.person.birthdate)))))),
            ),
          ),
        ));
  }
}
