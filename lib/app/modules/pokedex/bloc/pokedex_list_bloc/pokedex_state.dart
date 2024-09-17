part of 'pokedex_bloc.dart';

abstract class PokedexState {}

class PokedexStateInit extends PokedexState {}

class PokedexStateFetchPokemon extends PokedexState {
  final List<PokemonModel> pokemonModelList;
  final bool canLoad;
  final PokemonGenerationEnum generation;
  PokedexStateFetchPokemon({required this.pokemonModelList, required this.canLoad, required this.generation});
}

class PokedexStateLoading extends PokedexState {
  final List<PokemonModel> pokemonModelListHolder;
  final bool canLoad;
  final PokemonGenerationEnum generation;
  PokedexStateLoading({required this.pokemonModelListHolder, required this.canLoad, required this.generation});
}

class PokedexStateError extends PokedexState {
  final String error;
  final List<PokemonModel> pokemonModelListHolder;
  PokedexStateError({required this.pokemonModelListHolder, required this.error});
}
