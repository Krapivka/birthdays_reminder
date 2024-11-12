import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';

import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:birthdays_reminder/core/utils/snack_bar/snack_bar.dart';
import 'package:birthdays_reminder/features/birthday_changes/widgets/text_field_birthday_changes.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:birthdays_reminder/features/birthday_changes/update_birthday/bloc/update_birthday_bloc.dart';
import 'package:birthdays_reminder/generated/l10n.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      create: (context) => UpdateBirthdayBloc(
          context.read<AbstractPersonRepository>(),
          personmodel,
          context.read<AbstractSettingsRepository>()),
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
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar.show(context, S.of(context).fillInTheRequiredFields,
              color: Palette.unfinishedColor),
        );
      }
      if (state.status == UpdateBirthdayStatus.success) {
        AutoRouter.of(context).pushAndPopUntil(const HomeRoute(),
            predicate: (Route<dynamic> route) => false);
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).updateBirthday,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    context
                        .read<UpdateBirthdayBloc>()
                        .add(UpdateBirtdayDelete(state.id));
                  },
                  icon: const Icon(Icons.delete_outline_outlined))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const EditableImage(),
                  TextFieldBirthdayChanges(
                    labelText: S.of(context).enterNameInTextField,
                    hintText: S.of(context).hintTextNameInTextField,
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
                  SizedBox(
                    height: 100,
                    child: DatePicker(
                      onDateTimeChanged: (DateTime value) {
                        BlocProvider.of<UpdateBirthdayBloc>(context)
                            .add(UpdateBirtdayDateTap(value));
                      },
                    ),
                  ),
                  const _ButtonSaveBirthday(),
                ],
              ),
            ),
          ));
    });
  }
}

class EditableImage extends StatelessWidget {
  const EditableImage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateBirthdayBloc>();
    final width = MediaQuery.of(context).size.width / 3;
    final avatarPath = bloc.state.file.absolute.path;
    return Center(
      child: Material(
        child: InkWell(
          onTap: () {
            bloc.add(const UpdateBirtdayImageTap());
          },
          child: Ink(
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    image: avatarPath == '/'
                        ? const AssetImage(
                            "assets/images/default_person_image.png")
                        : FileImage(bloc.state.file) as ImageProvider),
              ),
              Positioned(
                right: 5,
                bottom: 5,
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
    return InkWell(
      onTap: () {
        context.read<UpdateBirthdayBloc>().add(const UpdateBirthdaySave());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Palette.primaryAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            S.of(context).updateBirthday,
            style: const TextStyle(color: Palette.secondaryLight),
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.onDateTimeChanged});

  final void Function(DateTime) onDateTimeChanged;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBirthdayBloc, UpdateBirthdayState>(
      builder: (context, state) {
        return CupertinoDatePicker(
            minimumDate: DateTime(1930),
            maximumDate: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            initialDateTime: state.birthdate,
            onDateTimeChanged: onDateTimeChanged);
      },
    );
  }
}
