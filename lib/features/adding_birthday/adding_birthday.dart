import 'package:birthdays_reminder/core/data/services/image_picker.dart';
import 'package:birthdays_reminder/core/domain/repositories/person_repository.dart';
import 'package:birthdays_reminder/features/adding_birthday/bloc/adding_birthday_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddingBirthdayPage extends StatelessWidget {
  const AddingBirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddingBirthdayBloc(context.read<PersonRepository>(),
          AppImagePicker(source: ImageSource.gallery)),
      child: AddingBirthdayView(),
    );
  }
}

class AddingBirthdayView extends StatelessWidget {
  AddingBirthdayView({
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
                  _EditableAvatar(),
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
                  _TextField(
                    labelText: "Enter date",
                    hintText: "Date",
                    showCursor: false,
                    controller: dataController,
                    onTap: () async {
                      final bloc = BlocProvider.of<AddingBirthdayBloc>(context);
                      final birthdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1930),
                          lastDate: DateTime.now());

                      if (birthdate != null) {
                        bloc.add(AddingBirtdayDateTap(birthdate));
                        dataController.text =
                            birthdate.toString().split(' ')[0];
                      }
                    },
                    icon: const Icon(Icons.date_range_outlined),
                  ),
                  _ButtonAddBirthday(),
                ],
              ),
            ));
      },
    );
  }
}

class _EditableAvatar extends StatelessWidget {
  const _EditableAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AddingBirthdayBloc>(context);
    final width = MediaQuery.of(context).size.width / 3;
    return Center(
      child: ElevatedButton(
        onPressed: () {
          bloc.add(AddingBirtdayImageTap());
        },
        child: CircleAvatar(
          radius: width / 1.5,
          backgroundImage: bloc.state.file != null
              ? FileImage(bloc.state.file!) as ImageProvider
              : NetworkImage(
                  "https://www.sunhome.ru/i/wallpapers/89/girls-v118.orig.jpg"),
        ),
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
        Navigator.pushNamedAndRemoveUntil(
            context, '/', (Route<dynamic> route) => false);
      },
      child: const Text("Add birthday"),
    );
  }
}