part of 'pokedex_bloc.dart';

abstract class PokedexState {
}

class PokedexStateInit extends PokedexState {}

class PokedexStateFetchPokemon extends PokedexState {
  final List<PokemonModel> pokemonModelList;
  PokedexStateFetchPokemon({required this.pokemonModelList});
}

class PokedexStateLoading extends PokedexState {
  final List<PokemonModel> pokemonModelListHolder;
  PokedexStateLoading({required this.pokemonModelListHolder});
}

class PokedexStateError extends PokedexState {
  final String error;
  PokedexStateError({required this.error});
}
