import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class PokemonLeftLabel extends StatelessWidget {
  final String name;

  const PokemonLeftLabel({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: RotatedBox(
        quarterTurns: 335,
        child: Opacity(
          opacity: .3,
          child: Text(
            Formatter.captalize(text: name),
            style: CustomTheme.title,
          ),
        ),
      ),
    );
  }
}
