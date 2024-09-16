import 'package:flutter/material.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/pokedex_search_input.dart';

class PokedexSearchBar extends StatelessWidget {
  const PokedexSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
        top: 30,
        bottom: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(
            child: PokedexSearchInput(),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
