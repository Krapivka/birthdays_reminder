import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';

import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:birthdays_reminder/features/birthday_changes/update_birthday/bloc/update_birthday_bloc.dart';
import 'package:birthdays_reminder/router/router.dart';
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
    return BlocBuilder<UpdateBirthdayBloc, UpdateBirthdayState>(
        builder: (context, state) {
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
                _TextField(
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
                _TextField(
                  labelText: "Enter date",
                  hintText: "Date",
                  showCursor: false,
                  controller: dataController,
                  onTap: () async {
                    final bloc = BlocProvider.of<UpdateBirthdayBloc>(context);
                    final birthdate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1930),
                        lastDate: DateTime.now());

                    if (birthdate != null) {
                      bloc.add(UpdateBirtdayDateTap(birthdate));
                      dataController.text = birthdate.toString().split(' ')[0];
                    }
                  },
                  icon: const Icon(Icons.date_range_outlined),
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
      child: InkWell(
        onTap: () {
          bloc.add(const UpdateBirtdayImageTap());
        },
        child: CircleAvatar(
            radius: width / 1.5,
            backgroundImage: avatarPath == '/'
                ? const AssetImage("assets/images/avatar.png")
                : FileImage(bloc.state.file) as ImageProvider),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField(
      {this.onChanged,
      this.labelText,
      this.hintText,
      this.icon,
      this.onTap,
      this.showCursor = true,
      this.controller,
      // ignore: unused_element
      this.readOnly = false});
  final void Function(String)? onChanged;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  final Icon? icon;
  final void Function()? onTap;
  final TextEditingController? controller;
  final bool? showCursor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: readOnly,
        showCursor: showCursor,
        enableInteractiveSelection: false,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
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
          labelText: labelText,
          hintText: hintText,
        ),
        onTap: onTap,
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