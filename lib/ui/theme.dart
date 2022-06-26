import 'package:flutter/material.dart';

MaterialColor orangeColor = Colors.orange;
MaterialColor blackColor = Colors.grey;
ThemeMode get lightThememode => ThemeMode.dark;
ThemeMode get darkThememode => ThemeMode.light;

class Themes {
  static final lightTheme = ThemeData(
    primarySwatch: orangeColor,
    brightness: Brightness.light,
  );

  static final darkTheme =
      ThemeData(primarySwatch: blackColor, brightness: Brightness.dark);
}
