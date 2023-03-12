import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final currentTheme = Colors.blue[200];

class AppTheme {
  static final mainTheme = ThemeData(
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 135, 196, 246),
        onPrimary: Colors.black,
        secondary: Color.fromARGB(255, 135, 196, 246),
        onSecondary: Colors.black,
        error: Color.fromARGB(255, 231, 115, 107),
        onError: Colors.black,
        background: Colors.white,
      ),
      cardTheme: cartTheme(),
      textTheme: appTextTheme());
}

TextTheme appTextTheme() {
  return GoogleFonts.comfortaaTextTheme();
}

cartTheme() {
  return CardTheme(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
}
