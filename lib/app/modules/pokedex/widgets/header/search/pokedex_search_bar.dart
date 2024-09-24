import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/header/search/pokedex_search_input.dart';
import 'package:pokedex_app/app/repositories/pokemon_name_list_repository.dart';

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
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Expanded(
                child: PokedexSearchInput(),
              ),
              const SizedBox(width: 5),
              IconButton(
                style: CustomTheme.primaryButton,
                onPressed: () {
                  context.read<PokemonNameListRepository>().searchInNameList('p');
                },
                padding: const EdgeInsets.all(12),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
