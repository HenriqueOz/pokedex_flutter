import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class Messenger {
  final BuildContext context;

  Messenger._({required this.context});

  factory Messenger.of(BuildContext context) {
    return Messenger._(context: context);
  }

  Future<void> showMessage(String message, Color textColor, Color backgroundColor) async {
    clearSnack();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: CustomTheme.body.copyWith(
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showError(String message) {
    showMessage(message, Colors.white, Colors.red);
  }

  void clearSnack() {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
