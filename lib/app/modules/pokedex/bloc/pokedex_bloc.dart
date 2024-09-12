import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
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
      final currentState = state;

      if (currentState is PokedexStateInit) {
        emit(PokedexStateLoading(pokemonModelListHolder: []));
        final list = await _fetchData(1, 6);
        emit(PokedexStateFetchPokemon(pokemonModelList: list));
      }

      if (currentState is PokedexStateFetchPokemon) {
        emit(PokedexStateLoading(pokemonModelListHolder: currentState.pokemonModelList));
        final list = await _fetchData(currentState.pokemonModelList.length + 1, 2);
        debugPrint('--------------------------------- Pokemon Loaded\n ${list.map((e) => e.name)}');
        emit(PokedexStateFetchPokemon(pokemonModelList: currentState.pokemonModelList + list));
      }
    } on Exception catch (e, s) {
      log('Erro ao carregar feed: ', error: e, stackTrace: s);
      emit(PokedexStateError(error: 'Erro ao carregar fedd'));
    }
  }

  Future<List<PokemonModel>> _fetchData(int start, int end) async {
    List<PokemonModel> pokemonModelList = [];
    for (int i = start; i < start + end; i++) {
      final pokemonModel = await _pokemonRepository.getPokemonById(id: i);
      pokemonModelList.add(pokemonModel);
    }

    return pokemonModelList;
  }
}
