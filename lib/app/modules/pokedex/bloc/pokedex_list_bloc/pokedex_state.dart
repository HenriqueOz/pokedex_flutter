part of 'pokedex_bloc.dart';

abstract class PokedexState {}

class PokedexStateInit extends PokedexState {}

class PokedexStateFetchPokemon extends PokedexState {
  final List<PokemonModel> pokemonModelList;
  final bool isLoading;
  final PokemonGenerationEnum generation;
  PokedexStateFetchPokemon({required this.pokemonModelList, required this.isLoading, required this.generation});
}

class PokedexStateLoading extends PokedexState {
  final List<PokemonModel> pokemonModelListHolder;
  final bool isLoading;
  final PokemonGenerationEnum generation;
  PokedexStateLoading({required this.pokemonModelListHolder, required this.isLoading, required this.generation});
}

class PokedexStateChangeGen extends PokedexState {
  final List<PokemonModel> pokemonModelListHolder;
  final bool isLoading;
  final PokemonGenerationEnum generation;
  PokedexStateChangeGen({required this.pokemonModelListHolder, required this.isLoading, required this.generation});
}

class PokedexStateError extends PokedexState {
  final String error;
  PokedexStateError({required this.error});
}
