import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:flutter/material.dart';

String _fontFamily = 'Montserrat';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Palette.primaryLight,
    primary: Palette.primaryLight,
    secondary: Palette.secondaryLight,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Palette.secondaryDark,
    selectionHandleColor: Palette.primaryAccent,
    selectionColor: Palette.primaryAccent,
  ),
  // appBarTheme: const AppBarTheme(
  //   color: Palette.primaryLight,
  // ),
  // bottomAppBarTheme: const BottomAppBarTheme(
  //   color: Palette.primaryLight,
  // ),
  // floatingActionButtonTheme: const FloatingActionButtonThemeData(
  //   backgroundColor: Palette.secondaryLight,
  // ),
  // iconTheme: IconThemeData(color: Palette.textLight),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.secondaryAccent),
  fontFamily: _fontFamily,
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Palette.primaryDark,
    primary: Palette.primaryDark,
    secondary: Palette.secondaryDark,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Palette.secondaryLight,
    selectionHandleColor: Palette.primaryAccent,
    selectionColor: Palette.primaryAccent,
  ),
  // appBarTheme: const AppBarTheme(
  //   color: Palette.primaryDark,
  // ),
  // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //   backgroundColor: Palette.primaryDark,
  // ),
  appBarTheme: const AppBarTheme(backgroundColor: Palette.primaryDark),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.primaryAccent),
  fontFamily: _fontFamily,
);


//   useMaterial3: true,
//   brightness: Brightness.light,
//   primaryColor: Palette.primary,
//   primaryColorDark: Palette.primaryDark,
//   appBarTheme: AppBarTheme(
//     color: Palette.primary,
//   ),
//   textSelectionTheme: const TextSelectionThemeData(
//     cursorColor: Palette.primaryDark,
//     selectionHandleColor: Palette.primaryDark,
//     selectionColor: Palette.primaryDark,
//   ),
//   focusColor: Palette.primaryDark,
//   inputDecorationTheme: InputDecorationTheme(
//     focusColor: Palette.primaryDark,
//     hoverColor: Palette.primaryDark,
//     floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
//       if (states.contains(MaterialState.error)) {
//         return const TextStyle(
//           color: Colors.red,
//         );
//       } else {
//         return const TextStyle(
//           color: Palette.primaryDark,
//         );
//       }
//     }),
//     focusedBorder: const UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Palette.primaryDark,
//         width: 2.0,
//       ),
//     ),
//   ),
//   scaffoldBackgroundColor: Palette.primary,
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//       foregroundColor: Palette.primaryDark,
//       textStyle: const TextStyle(
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ),
//   fontFamily: _fontFamily,
// );

// ThemeData darkTheme = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.dark,
//   primaryColor: Palette.primaryDark,
//   primaryColorDark: Palette.accentDark,
//   appBarTheme: const AppBarTheme(
//     color: Palette.primaryDark,
//   ),
//   textSelectionTheme: const TextSelectionThemeData(
//     cursorColor: Palette.primary,
//     selectionHandleColor: Palette.primary,
//     selectionColor: Palette.primary,
//   ),
//   focusColor: Palette.primary,
//   inputDecorationTheme: InputDecorationTheme(
//     focusColor: Palette.primary,
//     hoverColor: Palette.primary,
//     floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
//       if (states.contains(MaterialState.error)) {
//         return const TextStyle(
//           color: Colors.red,
//         );
//       } else {
//         return const TextStyle(
//           color: Palette.primary,
//         );
//       }
//     }),
//     focusedBorder: const UnderlineInputBorder(
//       borderSide: BorderSide(
//         color: Palette.primary,
//         width: 2.0,
//       ),
//     ),
//   ),
//   scaffoldBackgroundColor: Palette.primaryDark,
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//       foregroundColor: Palette.primary,
//       textStyle: const TextStyle(
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ),
//   fontFamily: _fontFamily,
// );
