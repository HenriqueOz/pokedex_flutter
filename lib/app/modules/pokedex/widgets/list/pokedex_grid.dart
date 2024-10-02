import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_pokemon_card.dart';

class PokedexGrid extends StatelessWidget {
  const PokedexGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PokedexBloc, PokedexState, List<PokemonModel>>(
      selector: (state) {
        if (state is PokedexStateLoading) {
          return state.pokemonModelListHolder;
        } else if (state is PokedexStateFetchPokemon) {
          return state.pokemonModelList;
        } else if (state is PokedexStateError) {
          return state.pokemonModelListHolder;
        }

        return <PokemonModel>[];
      },
      builder: (context, pokemonModelList) {
        final orientation = MediaQuery.of(context).orientation;
        final gridCrossAxisCount = orientation == Orientation.portrait ? 2 : 3;

        return Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCrossAxisCount,
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
            ),
            physics: const NeverScrollableScrollPhysics(), //* Desligando o scroll da ListView
            shrinkWrap: true, //* ListView com o tamanho necessário
            itemCount: pokemonModelList.length,
            itemBuilder: (context, index) {
              // debugPrint('${context.read<PokedexBloc>().state.runtimeType}');
              return PokedexPokemonCard(model: pokemonModelList[index]);
            },
          ),
        );
      },
    );
  }
}
