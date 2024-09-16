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

  static TextStyle hint = TextStyle(
    color: Colors.grey.shade400,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle pokedexLabels = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 16,
  );

  static const ButtonStyle primaryButton = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
    textStyle: WidgetStatePropertyAll(body),
    foregroundColor: WidgetStatePropertyAll(Colors.grey),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
    ),
  );

  static final themeData = ThemeData().copyWith(
    textTheme: GoogleFonts.chivoTextTheme(),
  );
}
