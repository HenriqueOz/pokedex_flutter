import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

//* instância que gerência um loader que cobre toda a tela
class FullscreenLoader {
  final BuildContext context;
  FullscreenLoader._({required this.context});

  factory FullscreenLoader.of(BuildContext context) {
    return FullscreenLoader._(context: context);
  }

  //* habilita o loader
  Future<void> showLoader() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const SimpleDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          children: [
            Center(
              child: CircularProgressIndicator(
                color: CustomTheme.primaryColor,
              ),
            )
          ],
        );
      },
    );
  }

  //* fecha o loader
  Future<void> hideLoader() async {
    Navigator.pop(context);
  }
}
