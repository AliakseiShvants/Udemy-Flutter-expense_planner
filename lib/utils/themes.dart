import 'package:expense_planner/utils/constants.dart';
import 'package:flutter/material.dart';

class Themes {
  static final TextTheme mainTextTheme = ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(
          fontFamily: Constants.OPEN_SANS,
          fontSize: Constants.FONT_M,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        button: const TextStyle(color: Colors.white),
      );

  static final TextTheme appBarTextTheme = ThemeData.light().textTheme.copyWith(
        headline6: const TextStyle(fontSize: Constants.FONT_L),
      );
}
