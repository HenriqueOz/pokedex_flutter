import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/header/pokedex_search_input.dart';

class PokedexSearchBar extends StatelessWidget {
  const PokedexSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
        top: 30,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(
            child: PokedexSearchInput(),
          ),
          const SizedBox(width: 5),
          IconButton(
            style: CustomTheme.primaryButton,
            onPressed: () {},
            padding: const EdgeInsets.all(12),
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
