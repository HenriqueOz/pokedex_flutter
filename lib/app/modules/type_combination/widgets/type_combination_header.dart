import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';

class TypeCombinationHeader extends StatelessWidget {
  const TypeCombinationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Text(
          'Type Combination',
          style: CustomTheme.title,
        ),
        SizedBox(height: 10),
        Text(
          'See the weaknesses and resistances of any type combination',
          style: CustomTheme.body,
        ),
      ],
    );
  }
}
