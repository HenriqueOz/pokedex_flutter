import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

//* instância que cuida da geração de SnackBars
class Messenger {
  final BuildContext context;

  Messenger._({required this.context});

  factory Messenger.of(BuildContext context) {
    return Messenger._(context: context);
  }

  //* snackbar customizada
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

  //* snakcbar de erro
  void showError(String message) {
    showMessage(message, Colors.white, Colors.red);
  }

  //* limpa o queue de snackbar
  void clearSnack() {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
