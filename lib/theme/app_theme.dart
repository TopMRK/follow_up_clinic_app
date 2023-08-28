import 'package:flutter/material.dart';
import './color_scheme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: AppColorScheme.lightScheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0x003BA55F),
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: 'NotoSansThai',
    // textTheme: TextTheme(
    //   displayLarge:
    // ),
  );
}
