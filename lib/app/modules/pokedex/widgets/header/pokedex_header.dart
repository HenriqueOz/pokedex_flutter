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
              'Pokédex',
              style: CustomTheme.title,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Explore the pokémons list and discover their characteristics.',
              style: CustomTheme.body,
            ),
          ],
        ),
      ),
    );
  }
}
