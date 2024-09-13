part of 'pokedex_bloc.dart';

abstract class PokedexState {}

class PokedexStateInit extends PokedexState {}

class PokedexStateFetchPokemon extends PokedexState {
  final List<PokemonModel> pokemonModelList;
  bool isLoading = false;
  PokedexStateFetchPokemon({required this.pokemonModelList, required this.isLoading});
}

class PokedexStateLoading extends PokedexState {
  final List<PokemonModel> pokemonModelListHolder;
  bool isLoading = false;
  PokedexStateLoading({required this.pokemonModelListHolder, required this.isLoading});
}

class PokedexStateError extends PokedexState {
  final String error;
  PokedexStateError({required this.error});
}
