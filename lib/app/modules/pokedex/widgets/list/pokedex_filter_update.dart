import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/modules/pokedex/bloc/pokedex_list_bloc/pokedex_bloc.dart';
import 'package:pokedex_app/app/modules/pokedex/widgets/list/pokedex_gen_filter.dart';

class PokedexFilterUpdate extends StatefulWidget {
  const PokedexFilterUpdate({super.key});

  @override
  State<PokedexFilterUpdate> createState() => _PokedexFilterUpdateState();
}

class _PokedexFilterUpdateState extends State<PokedexFilterUpdate> {
  PokemonGenerationBounds selectedGen = PokemonGenerationBounds.gen1;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PokedexBloc, PokedexState, PokemonGenerationBounds>(
      selector: (state) {
        if (state is PokedexStateFetchPokemon) {
          selectedGen = state.generation;
        } else if (state is PokedexStateLoading) {
          selectedGen = state.generation;
        }
        return selectedGen;
      },
      builder: (context, generation) {
        return PokedexGenFilter(selectedGeneration: generation);
      },
    );
  }
}
