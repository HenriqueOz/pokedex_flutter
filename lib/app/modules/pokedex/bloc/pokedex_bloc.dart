import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final PokemonRepository _pokemonRepository;

  PokedexBloc({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository,
        super(PokedexStateInit()) {
          on<PokedexEventLoad>(_load);
        }

  Future<void> _load(PokedexEventLoad event, Emitter<PokedexState> emit) async {
    try {
      emit(PokedexStateLoading());

      final currentState = state;
      List<PokemonModel> pokemonModelList = [];

      if (currentState is PokedexStateInit) {
        pokemonModelList = currentState.pokemonModelList;
      } else if (currentState is PokedexStateFetchPokemon) {
        pokemonModelList = currentState.pokemonModelList;
      }

      for (int i = pokemonModelList.length + 1; i <= event.quantity; i++) {
        final pokemonModel = await _pokemonRepository.getPokemonById(id: i);
        pokemonModelList.add(pokemonModel);
      }

      emit(PokedexStateFetchPokemon(pokemonModelList: pokemonModelList));

    } catch (e, s) {
      log('Erro ao carregar feed: ', error: e, stackTrace: s);
      emit(PokedexStateError(error: 'Erro ao carregar fedd'));
    }
  }
}
