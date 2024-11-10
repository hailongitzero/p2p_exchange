import 'package:flutter/material.dart';

class ThemeApp {
  static final light = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      // primaryColor: Colors.blue,
      // colorSchemeSeed: Colors.blueAccent,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(color: Colors.blue),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          )));

  static final dart = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      // primaryColor: Colors.blue,
      // colorSchemeSeed: Colors.blueAccent,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        color: Colors.orange,
      ),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          )));
}
