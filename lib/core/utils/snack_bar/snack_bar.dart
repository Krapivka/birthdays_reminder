import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:flutter/material.dart';

const snackBar = SnackBar(
  content: Text(
    'You have not entered a required field!',
    style: TextStyle(color: Palette.textLight),
  ),
  backgroundColor: Palette.secondaryAccent,
);
