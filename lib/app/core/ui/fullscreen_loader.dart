import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class FullscreenLoader {
  final BuildContext context;
  FullscreenLoader._({required this.context});

  factory FullscreenLoader.of(BuildContext context) {
    return FullscreenLoader._(context: context);
  }

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

  Future<void> hideLoader() async {
    Navigator.pop(context);
  }
}
