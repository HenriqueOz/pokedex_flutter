import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class PokedexHeader extends StatelessWidget {
  const PokedexHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pokedéx',
              style: CustomTheme.title,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Explore a lista de Pokémons e descubra suas principais características.',
              style: CustomTheme.body,
            ),
          ],
        ),
      ),
    );
  }
}
