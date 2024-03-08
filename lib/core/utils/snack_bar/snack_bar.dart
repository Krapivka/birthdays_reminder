import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static SnackBar getSnackBar(String message) {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Palette.textLight),
      ),
      backgroundColor: Palette.secondaryAccent,
    );
  }
}
