import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const primaryColor = Color.fromARGB(255, 248, 107, 107);
  static const secondaryColor = Color(0xFF635555);

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
    backgroundColor: WidgetStatePropertyAll(primaryColor),
    textStyle: WidgetStatePropertyAll(body),
    elevation: WidgetStatePropertyAll(3),
    foregroundColor: WidgetStatePropertyAll(Colors.white),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );

  static ButtonStyle secondaryButton = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.grey.shade100),
    textStyle: const WidgetStatePropertyAll(body),
    foregroundColor: WidgetStatePropertyAll(Colors.grey.shade500),
    shape: const WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );

  static final themeData = ThemeData().copyWith(
      textTheme: GoogleFonts.chivoTextTheme(),
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      primaryColor: primaryColor,
      splashColor: Colors.grey,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor,
        selectionHandleColor: primaryColor,
      ));
}
