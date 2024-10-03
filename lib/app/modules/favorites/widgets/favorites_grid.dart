import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/modules/favorites/bloc/favorites_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_pokemon_card.dart';

class FavoritesGrid extends StatelessWidget {
  const FavoritesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesBloc, FavoritesStates, List>(
      selector: (state) {
        if (state is FavoritesFetch) {
          return state.list;
        } else if (state is FavoritesLoading) {
          return state.list;
        } else if (state is FavoritesError) {
          return state.list;
        }
        return <PokemonModel>[];
      },
      builder: (context, list) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 16,
          ),
          physics: const NeverScrollableScrollPhysics(), //* Desligando o scroll da ListView
          shrinkWrap: true, //* ListView com o tamanho necessário
          itemCount: list.length,
          itemBuilder: (context, index) {
            // debugPrint('${context.read<PokedexBloc>().state.runtimeType}');
            return PokedexPokemonCard(model: list[index]);
          },
        );
      },
    );
  }
}
