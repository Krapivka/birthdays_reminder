import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/adding_birthday/bloc/adding_birthday_bloc.dart';
import 'package:birthdays_reminder/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:birthdays_reminder/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

@RoutePage()
class AddingBirthdayPage extends StatelessWidget {
  const AddingBirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddingBirthdayBloc(
        context.read<PersonRepository>(),
        context.read<AbstractSettingsRepository>(),
      ),
      child: AddingBirthdayView(),
    );
  }
}

class AddingBirthdayView extends StatelessWidget {
  const AddingBirthdayView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController dataController = TextEditingController();
    return BlocBuilder<AddingBirthdayBloc, AddingBirthdayState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Add birthday",
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
                          .read<AddingBirthdayBloc>()
                          .add(AddingBirtdayNameChanged(value));
                    },
                    icon: const Icon(Icons.person_2_outlined),
                  ),
                  SizedBox(
                    height: 100,
                    child: DatePicker(),
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
            ));
      },
    );
  }
}

class _EditableAvatar extends StatelessWidget {
  const _EditableAvatar();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddingBirthdayBloc>();
    final width = MediaQuery.of(context).size.width / 3;
    final avatarPath = bloc.state.file.absolute.path;
    return Center(
      child: InkWell(
        onTap: () {
          bloc.add(const AddingBirtdayImageTap());
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

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddingBirthdayBloc>();
    return ScrollDatePicker(
      selectedDate: bloc.state.birthdate,
      locale: const Locale('ru'),
      onDateTimeChanged: (DateTime value) {
        bloc.add(AddingBirtdayDateTap(value));
      },
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

class _ButtonAddBirthday extends StatelessWidget {
  const _ButtonAddBirthday({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context.read<AddingBirthdayBloc>().add(const AddingBirthdaySubmitted());
        AutoRouter.of(context).pushAndPopUntil(const HomeRoute(),
            predicate: (Route<dynamic> route) => false);
      },
      child: const Text("Add birthday"),
    );
  }
}
