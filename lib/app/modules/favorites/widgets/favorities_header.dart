import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class FavoritesHeader extends StatelessWidget {
  const FavoritesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          'Favorites',
          style: CustomTheme.title,
        ),
        SizedBox(height: 10),
        Text(
          'See all pokemon you tagged as favorite.',
          style: CustomTheme.body,
        ),
      ],
    );
  }
}
