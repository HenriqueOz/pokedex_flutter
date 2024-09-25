import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/core/ui/fullscreen_loader.dart';
import 'package:pokedex_app/app/core/ui/messenger.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_search_bloc/pokedex_search_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/header/search/pokedex_search_input.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

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
              BlocSelector<PokedexSearchBloc, PokedexSearchState, List<String>>(
                selector: (state) {
                  if (state is PokedexSearchFetch) {
                    return state.list;
                  }
                  return [];
                },
                builder: (context, list) {
                  return IconButton(
                    style: CustomTheme.primaryButton,
                    onPressed: () async {
                      if (list.length == 1) {
                        try {
                          final String name = list.first;
                          FullscreenLoader.of(context).showLoader();

                          final PokemonModel model = await context.read<PokemonRepository>().getPokemonByName(name: name);
                          FullscreenLoader.of(context).hideLoader();

                          Navigator.pushNamed(context, '/pokemon/', arguments: model);
                        } on MessageException catch (e) {
                          FullscreenLoader.of(context).hideLoader();
                          Messenger.of(context).showError(e.message);
                        }
                      }
                    },
                    padding: const EdgeInsets.all(12),
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
