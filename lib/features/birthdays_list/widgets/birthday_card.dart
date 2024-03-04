import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/utils/animations/show_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:birthdays_reminder/core/data/models/person_model.dart';
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

  void animateCard() async {
    await Future.delayed(const Duration(milliseconds: 300)).then((value) {
      if (mounted) {
        _visible = false;
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
        animateCard();
        return AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  if (state.selectedPersonId.isEmpty) {
                    AutoRouter.of(context)
                        .push(UpdateBirthdayRoute(personmodel: widget.person));
                  } else {
                    birthdayListBloc
                        .add(TapBirthdayCardEvent(id: widget.person.id));
                  }
                },
                onLongPress: () {
                  birthdayListBloc
                      .add(LongPressBirthdayCardEvent(id: widget.person.id));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: birthdayListBloc.state.selectedPersonId
                            .contains(widget.person.id)
                        ? Color.fromARGB(255, 223, 223, 223)
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: widget.person.filePath == "/"
                            ? const AssetImage("assets/images/avatar.png")
                            : FileImage(file) as ImageProvider,
                      ),
                      title: ShowUp(
                        delay: 100,
                        child: Text(
                          widget.person.name,
                          maxLines: 1,
                        ),
                      ),
                      subtitle: ShowUp(
                        delay: 300,
                        child: Text(DateTimeUtils.formatDate(
                            widget.person.birthdate,
                            settingsBloc.state.dateFormat)),
                      ),
                      trailing: DateTimeUtils.getDifferenceCurrentDayBirthDay(
                                  widget.person.birthdate) !=
                              '0'
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 1),
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
                            )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
