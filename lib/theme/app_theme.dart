import 'package:flutter/material.dart';
import './color_scheme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.lightScheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xff3BA55F),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3BA55F), // background (button) color
        foregroundColor: Colors.white, // foreground (text) color
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFcdcdcd)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFcdcdcd)),
      ),
    ),
    fontFamily: 'NotoSansThai',
    // textTheme: TextTheme(
    //   displayLarge:
    // ),
  );
}
