import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ActionButton extends StatelessWidget {
  String text;

  ActionButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Palette.primaryAccent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: const TextStyle(color: Palette.primaryLight),
        ),
      ),
    );
  }
}
