import 'package:birthdays_reminder/utils/constants/Palette.dart';
import 'package:flutter/material.dart';

String _fontFamily = 'Montserrat';
ThemeData theme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: Palette.primary,
  primaryColorDark: Palette.accentOrange,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Palette.accentOrange,
    selectionHandleColor: Palette.accentOrange,
    selectionColor: Palette.accentOrange,
  ),
  focusColor: Palette.accentOrange,
  inputDecorationTheme: InputDecorationTheme(
    focusColor: Palette.accentOrange,
    hoverColor: Palette.accentOrange,
    floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
      if (states.contains(MaterialState.error)) {
        return const TextStyle(
          color: Colors.red,
        );
      } else {
        return const TextStyle(
          color: Palette.accentOrange,
        );
      }
    }),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Palette.accentOrange,
        width: 2.0,
      ),
    ),
  ),
  scaffoldBackgroundColor: Palette.primary,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Palette.accentOrange,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  fontFamily: _fontFamily,
);
