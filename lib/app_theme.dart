import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    // colours for material 3, setup
    // define the default brightness and colors.
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 31, 67, 107), // custom swatch
      // will contrast a dark background
      brightness: Brightness.dark,
    ),
    fontFamily: 'RedHatDisplay',
    // chosen text asset included in files..
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: (TextStyle(
        fontFamily: 'RedHatDisplay',
        fontSize: 26,
        fontWeight: FontWeight.bold,
      )),
      bodyMedium: TextStyle(
        fontFamily: 'OpenSans',
      ),
      displaySmall: TextStyle(fontFamily: 'OpenSans'),
    ),
  );
}
