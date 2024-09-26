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
          //* row do input de pesquisa e botão de pesquisa
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //* input de pesquisa
              const Expanded(
                child: PokedexSearchInput(),
              ),
              const SizedBox(width: 5),
              //* trazendo a lista de pesquisa armazenada no state do meu bloc
              BlocSelector<PokedexSearchBloc, PokedexSearchState, List<String>>(
                selector: (state) {
                  if (state is PokedexSearchFetch) {
                    return state.list;
                  }
                  return [];
                },
                builder: (context, list) {
                  //* botão de pesquisa
                  return IconButton(
                    style: CustomTheme.primaryButton,
                    onPressed: () async {
                      if (list.length == 1) {
                        try {
                          //* pegando o único valor que sobrou na lista após a digitação
                          //* que, logicamente, será sempre o primeiro
                          final String name = list.first;
                          FullscreenLoader.of(context).showLoader(); //* chamando o loader

                          //* requisando um pokemon model pro meu repository
                          final PokemonModel model = await context.read<PokemonRepository>().searchPokemonByName(name: name);
                          FullscreenLoader.of(context).hideLoader(); //* fechando meu loader

                          Navigator.pushNamed(context, '/pokemon/', arguments: model); //* indo para tela do pokemon que pesquisei
                        } on MessageException catch (e) {
                          FullscreenLoader.of(context).hideLoader(); //* escondendo loader
                          Messenger.of(context).showError(e.message); //* mostrando error
                        }
                      }
                    },
                    padding: const EdgeInsets.all(12),
                    //* icone do botão
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
