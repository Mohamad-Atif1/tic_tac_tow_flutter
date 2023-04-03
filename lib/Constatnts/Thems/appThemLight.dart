import 'package:flutter/material.dart';

import 'package:tic_tac_tow_flutter/Constatnts/Colors/app_light_colors.dart';

import '../Numaric/numaric.dart';

ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: appWhite,
    cardColor: appBlue,
    textTheme: myTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))))));

TextTheme myTextTheme() {
  return const TextTheme(
    displayLarge: TextStyle(
      fontSize: displayLargeSize,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
        fontSize: titleLarge, fontWeight: FontWeight.w300, color: appWhite),
    titleMedium: TextStyle(fontSize: titleMeduim, fontWeight: FontWeight.w300),
  );
}
