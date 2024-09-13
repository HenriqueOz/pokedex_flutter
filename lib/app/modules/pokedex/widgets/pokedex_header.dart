import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class PokedexHeader extends StatelessWidget {
  const PokedexHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pokedéx',
              style: CustomTheme.title,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Definitivamente uma pokedéx, sem dúvida alguma um artifício tecnológico feito para listar criaturas de fantasia.',
              style: CustomTheme.body,
            ),
          ],
        ),
      ),
    );
  }
}
