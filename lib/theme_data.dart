import 'package:flutter/material.dart';

class MaterialThemeData extends TotalTheme {
  static const Color _lightPrimary = Color.fromARGB(255, 255, 255, 255);
  static const Color _lightOnPrimary = Color(0xff000000);
  static const Color _lightBackground = Color.fromARGB(255, 243, 243, 243);
  static const Color _lightOnBackground = Color(0xff000000);
  static const Color _lightSurface = Color.fromARGB(255, 58, 85, 145);
  static const Color _lightOnSurface = Color(0xff000000);
  static const Color _lightError = Color.fromARGB(255, 58, 85, 145);
  static const Color _lightOnError = Color.fromARGB(255, 164, 170, 188);

  static const Color _darkPrimary = Color.fromARGB(255, 37, 37, 37);
  static const Color _darkOnPrimary = Color(0xffffffff);
  static const Color _darkBackground = Color.fromARGB(255, 0, 0, 0);
  static const Color _darkOnBackground = Color(0xffffffff);
  static const Color _darkSurface = Color.fromARGB(255, 35, 51, 87);
  static const Color _darkOnSurface = Color(0xffffffff);
  static const Color _darkError = Color.fromARGB(255, 58, 85, 145);
  static const Color _darkOnError = Color.fromARGB(255, 68, 71, 79);

  @override
  ThemeData light() => ThemeData(
        scaffoldBackgroundColor: _lightBackground,
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: _lightPrimary,
          onPrimary: _lightOnPrimary,
          secondary: Color.fromRGBO(58, 85, 145, 1),
          onSecondary: Color.fromARGB(255, 255, 255, 255),
          background: _lightBackground,
          onBackground: _lightOnBackground,
          surface: _lightSurface,
          onSurface: _lightOnSurface,
          error: _lightError,
          onError: _lightOnError,
        ),
      );

  @override
  ThemeData dark() => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: _darkPrimary,
          onPrimary: _darkOnPrimary,
          secondary: Color.fromARGB(255, 58, 85, 145),
          onSecondary: Color.fromARGB(255, 255, 255, 255),
          background: _darkBackground,
          onBackground: _darkOnBackground,
          surface: _darkSurface,
          onSurface: _darkOnSurface,
          error: _darkError,
          onError: _darkOnError,
        ),
      );

  static ThemeData getLightTheme() => MaterialThemeData().light();
  static ThemeData getDarkTheme() => MaterialThemeData().dark();
}

class TotalTheme {
  ThemeData light() => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      );
  ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      );
}
