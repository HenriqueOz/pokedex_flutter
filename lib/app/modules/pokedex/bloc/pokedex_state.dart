part of 'pokedex_bloc.dart';

abstract class PokedexState {}

//----------------------------------------
//* Inicializando a lista de pokemons do feed
//----------------------------------------
class PokedexStateInit extends PokedexState {
  final List<PokemonModel> pokemonModelList = [];
  PokedexStateInit();
}

//----------------------------------------
//* Armazena a lista repopulada do feed
//----------------------------------------
class PokedexStateFetchPokemon extends PokedexState {
  final List<PokemonModel> pokemonModelList;
  PokedexStateFetchPokemon({
    required this.pokemonModelList,
  });
}

class PokedexStateLoading extends PokedexState {}

class PokedexStateError extends PokedexState {
  final String error;
  PokedexStateError({required this.error});
}

