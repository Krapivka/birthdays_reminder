import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';

import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:birthdays_reminder/features/birthday_changes/widgets/text_field_birthday_changes.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:birthdays_reminder/features/birthday_changes/update_birthday/bloc/update_birthday_bloc.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

@RoutePage()
class UpdateBirthdayPage extends StatelessWidget {
  const UpdateBirthdayPage({
    super.key,
    required this.personmodel,
  });

  final PersonModel personmodel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBirthdayBloc(context.read<PersonRepository>(),
          personmodel, context.read<AbstractSettingsRepository>()),
      child: UpdateBirthdayPageView(),
    );
  }
}

// ignore: must_be_immutable
class UpdateBirthdayPageView extends StatelessWidget {
  UpdateBirthdayPageView({
    super.key,
  });
  TextEditingController nameController = TextEditingController();
  TextEditingController dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UpdateBirthdayBloc>(context).state;
    nameController.text = bloc.name;
    dataController.text = bloc.birthdate.toString().split(' ')[0];
    return BlocConsumer<UpdateBirthdayBloc, UpdateBirthdayState>(
        listener: (context, state) {
      if (state.status == UpdateBirthdayStatus.validatorFailure) {
        const snackBar = SnackBar(
          content: Text('You have not entered a required field!'),
          backgroundColor: Palette.accent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }, builder: (context, state) {
      if (state.status == UpdateBirthdayStatus.success) {
        AutoRouter.of(context).popAndPush(const HomeRoute());
      }
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Update birthday",
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const _EditableAvatar(),
                TextFieldBirthdayChanges(
                  labelText: "Enter name",
                  hintText: "Name",
                  onChanged: (value) {
                    context
                        .read<UpdateBirthdayBloc>()
                        .add(UpdateBirtdayNameChanged(value));
                  },
                  controller: nameController,
                  icon: const Icon(Icons.person_2_outlined),
                ),
                // _TextField(
                //   labelText: "Enter date",
                //   hintText: "Date",
                //   showCursor: false,
                //   controller: dataController,
                //   onTap: () async {
                //     final bloc = BlocProvider.of<UpdateBirthdayBloc>(context);
                //     final birthdate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(1930),
                //         lastDate: DateTime.now());

                //     if (birthdate != null) {
                //       bloc.add(UpdateBirtdayDateTap(birthdate));
                //       dataController.text = birthdate.toString().split(' ')[0];
                //     }
                //   },
                //   icon: const Icon(Icons.date_range_outlined),
                // ),
                const SizedBox(
                  height: 100,
                  child: DatePicker(),
                ),
                const _ButtonSaveBirthday(),
              ],
            ),
          ));
    });
  }
}

class _EditableAvatar extends StatelessWidget {
  const _EditableAvatar();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateBirthdayBloc>();
    final width = MediaQuery.of(context).size.width / 3;
    final avatarPath = bloc.state.file.absolute.path;
    return Center(
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            bloc.add(const UpdateBirtdayImageTap());
          },
          child: Ink(
            child: Stack(children: [
              CircleAvatar(
                  radius: width / 1.3,
                  backgroundImage: avatarPath == '/'
                      ? const AssetImage("assets/images/avatar.png")
                      : FileImage(bloc.state.file) as ImageProvider),
              Positioned(
                right: 0,
                bottom: 0,
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    bloc.add(const UpdateBirtdayImageTap());
                  },
                  child: const Icon(Icons.brush),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _ButtonSaveBirthday extends StatelessWidget {
  const _ButtonSaveBirthday();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        BlocProvider.of<UpdateBirthdayBloc>(context)
            .add(const UpdateBirthdaySave());
      },
      child: const Text("Save"),
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateBirthdayBloc>();
    return ScrollDatePicker(
      selectedDate: bloc.state.birthdate,
      locale: const Locale('ru'),
      onDateTimeChanged: (DateTime value) {
        bloc.add(UpdateBirtdayDateTap(value));
      },
    );
  }
}
