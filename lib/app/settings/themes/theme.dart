import 'package:flutter/material.dart';

class ThemeApp {
  static final light = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
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
      brightness: Brightness.dark,
      primaryColor: Colors.orange,
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
