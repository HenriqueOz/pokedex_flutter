import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const primary = Color(0xFFFF5B5B);

  static const TextStyle title = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 32,
  );

  static const TextStyle body = TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  static final themeData = ThemeData().copyWith(
    textTheme: GoogleFonts.chivoTextTheme(),
  );
}