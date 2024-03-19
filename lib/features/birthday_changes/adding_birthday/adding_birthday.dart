import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:birthdays_reminder/core/utils/snack_bar/snack_bar.dart';
import 'package:birthdays_reminder/features/birthday_changes/adding_birthday/bloc/adding_birthday_bloc.dart';
import 'package:birthdays_reminder/features/birthday_changes/widgets/text_field_birthday_changes.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:birthdays_reminder/generated/l10n.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AddingBirthdayPage extends StatelessWidget {
  const AddingBirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddingBirthdayBloc(
        context.read<AbstractPersonRepository>(),
        context.read<AbstractSettingsRepository>(),
      ),
      child: const AddingBirthdayView(),
    );
  }
}

class AddingBirthdayView extends StatelessWidget {
  const AddingBirthdayView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddingBirthdayBloc, AddingBirthdayState>(
      listener: (context, state) {
        if (state.status == AddingBirthdayStatus.validatorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBar.getSnackBar(S.of(context).fillInTheRequiredFields));
        }
        if (state.status == AddingBirthdayStatus.success) {
          AutoRouter.of(context).pushAndPopUntil(const HomeRoute(),
              predicate: (Route<dynamic> route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).addBirthday,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const EditableAvatar(),
                    TextFieldBirthdayChanges(
                      labelText: S.of(context).enterNameInTextField,
                      hintText: S.of(context).hintTextNameInTextField,
                      onChanged: (value) {
                        context
                            .read<AddingBirthdayBloc>()
                            .add(AddingBirtdayNameChanged(value));
                      },
                      icon: const Icon(Icons.person_2_outlined),
                    ),
                    SizedBox(
                      height: 100,
                      child: DatePicker(onDateTimeChanged: (DateTime value) {
                        BlocProvider.of<AddingBirthdayBloc>(context)
                            .add(AddingBirtdayDateTap(value));
                      }),
                    ),
                    // _TextField(
                    //   labelText: "Enter date",
                    //   hintText: "Date",
                    //   showCursor: false,
                    //   controller: dataController,
                    //   onTap: () async {
                    //     final bloc = BlocProvider.of<AddingBirthdayBloc>(context);
                    //     final birthdate = await showDatePicker(
                    //         context: context,
                    //         initialDate: DateTime.now(),
                    //         firstDate: DateTime(1900),
                    //         lastDate: DateTime.now());

                    //     if (birthdate != null) {
                    //       bloc.add(AddingBirtdayDateTap(birthdate));
                    //       dataController.text =
                    //           birthdate.toString().split(' ')[0];
                    //     }
                    //   },
                    //   icon: const Icon(Icons.date_range_outlined),
                    // ),
                    const _ButtonAddBirthday(),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

class EditableAvatar extends StatelessWidget {
  const EditableAvatar();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddingBirthdayBloc>();
    final width = MediaQuery.of(context).size.width / 3;
    final avatarPath = bloc.state.file.absolute.path;
    return Center(
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            bloc.add(const AddingBirtdayImageTap());
          },
          child: Ink(
            color: Theme.of(context).colorScheme.primary,
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
                    bloc.add(const AddingBirtdayImageTap());
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

class _ButtonAddBirthday extends StatelessWidget {
  const _ButtonAddBirthday({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AddingBirthdayBloc>().add(const AddingBirthdaySubmitted());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Palette.primaryAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            S.of(context).addBirthdayButton,
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
    return BlocBuilder<AddingBirthdayBloc, AddingBirthdayState>(
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
