import 'package:flutter/material.dart';

class AddingBirthdayPage extends StatelessWidget {
  const AddingBirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AddingBirthdayView();
  }
}

class AddingBirthdayView extends StatelessWidget {
  const AddingBirthdayView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add birthday",
          ),
          centerTitle: true,
        ),
        body: const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _CircleAvatar(),
              _TitleField("Enter name"),
              _TitleField("Enter date"),
              _ButtonAddBirthday(),
            ],
          ),
        ));
  }
}

class _CircleAvatar extends StatelessWidget {
  const _CircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 3;
    return Center(
        child: Container(
      child: CircleAvatar(
        radius: width / 1.5,
        backgroundImage: NetworkImage(
            "https://www.sunhome.ru/i/wallpapers/89/girls-v118.orig.jpg"),
      ),
    ));
  }
}

class _TitleField extends StatelessWidget {
  final String hintText;
  const _TitleField(this.hintText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}

class _ButtonAddBirthday extends StatelessWidget {
  const _ButtonAddBirthday({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Text("Add birthday"),
    );
  }
}
