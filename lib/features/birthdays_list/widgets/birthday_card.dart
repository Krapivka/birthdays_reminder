import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:birthdays_reminder/core/utils/date_utils/date_utils.dart';
import 'package:birthdays_reminder/features/birthdays_list/bloc/birthdays_list_bloc.dart';
import 'package:birthdays_reminder/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:birthdays_reminder/router/router.dart';

class BirthdayCard extends StatefulWidget {
  const BirthdayCard({
    required this.person,
    required this.index,
  });
  final PersonModel person;
  final int index;

  @override
  State<BirthdayCard> createState() => _BirthdayCardState();
}

class _BirthdayCardState extends State<BirthdayCard> {
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
    final file = File(widget.person.filePath);
    final settingsBloc = context.watch<SettingsBloc>();
    final birthdayListBloc = BlocProvider.of<BirthdaysListBloc>(context);

    return BlocBuilder<BirthdaysListBloc, BirthdaysListState>(
      builder: (context, state) {
        //use animate when widget rebuild
        animate();
        return InkWell(
          onTap: () {
            if (state.selectedPersonId.isEmpty) {
              AutoRouter.of(context)
                  .push(UpdateBirthdayRoute(personmodel: widget.person));
            } else {
              birthdayListBloc.add(TapBirthdayCardEvent(id: widget.person.id));
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
            birthdayListBloc
                .add(LongPressBirthdayCardEvent(id: widget.person.id));
          },
          child: AnimatedOpacity(
            //TODO: animate widget
            opacity: _visible ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Card(
                color: birthdayListBloc.state.selectedPersonId
                        .contains(widget.person.id)
                    ? const Color.fromARGB(255, 230, 230, 230)
                    : Palette.primary,
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
                        widget.person.birthdate,
                        settingsBloc.state.dateFormat)),
                    trailing: DateTimeUtils.getDifferenceCurrentDayBirthDay(
                                widget.person.birthdate) !=
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
                                  widget.person.birthdate),
                              style: const TextStyle(fontSize: 12),
                            )))
                        : SizedBox(
                            height: 40,
                            width: 40,
                            child: SvgPicture.asset(
                                'assets/images/confetti.svg',
                                semanticsLabel: 'Confetti'),
                          ))),
          ),
        );
      },
    );
  }
}
