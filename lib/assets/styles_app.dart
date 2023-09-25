import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StylesApp {
  static ThemeData lightTheme(BuildContext context) {
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 255, 0, 0),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 50, 10, 10),
      ),
    );
  }

  // Agrega una función para guardar el tema seleccionado en SharedPreferences.
  static Future<void> saveTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme);
  }
}