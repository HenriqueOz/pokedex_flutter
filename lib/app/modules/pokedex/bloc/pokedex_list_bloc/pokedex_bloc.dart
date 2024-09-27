import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final PokemonRepository _pokemonRepository;
  PokemonGenerationBounds _generation = PokemonGenerationBounds.gen1;

  PokedexBloc({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository,
        super(PokedexStateInit()) {
    on<PokedexEventLoad>(_load);
    on<PokedexEventChangeGen>(_changeGen);
  }

  Future<void> _load(PokedexEventLoad event, Emitter<PokedexState> emit) async {
    final currentState = state;

    if (currentState is PokedexStateInit) {
      emit(PokedexStateFetchPokemon(pokemonModelList: [], canLoad: true, generation: _generation));
      add(PokedexEventLoad());
    }

    if (currentState is PokedexStateError) {
      emit(PokedexStateFetchPokemon(pokemonModelList: currentState.pokemonModelListHolder, canLoad: true, generation: _generation));
      add(PokedexEventLoad());
    }

    if (currentState is PokedexStateFetchPokemon) {
      try {
        bool canLoad = false;
        int toLoad = 10; //* Número de pokemons que serão carregados por scroll
        final int listLength = currentState.pokemonModelList.length;

        final int genLimit = _generation.limit;
        final int offset = _generation.offset + listLength;

        //* Limitando o toLoad para não ultrapassar o limite da geração
        if ((listLength + toLoad) > genLimit) {
          toLoad = genLimit - listLength;
        }

        if (toLoad != 0) {
          canLoad = true;
        }

        final oldList = currentState.pokemonModelList;

        emit(PokedexStateLoading(pokemonModelListHolder: oldList, canLoad: canLoad, generation: _generation));
        final list = await _fetchData(quantity: toLoad, offset: offset);

        emit(PokedexStateFetchPokemon(pokemonModelList: oldList + list, canLoad: canLoad, generation: _generation));
      } on MessageException catch (e, s) {
        log(e.message, error: e, stackTrace: s);
        emit(PokedexStateError(error: e.message, pokemonModelListHolder: currentState.pokemonModelList));
      }
    }
  }

  Future<List<PokemonModel>> _fetchData({required int offset, required int quantity}) async {
    final List<Future<PokemonModel>> toFetchList = [];

    quantity = quantity + offset;
    for (int i = offset; i < quantity; i++) {
      toFetchList.add(_pokemonRepository.getPokemonById(id: i + 1));
    }

    final fetchedList = Future.wait(toFetchList);

    return fetchedList;
  }

  Future<void> _changeGen(PokedexEventChangeGen event, Emitter<PokedexState> emit) async {
    if (_generation != event.generation && state is! PokedexStateLoading) {
      _generation = event.generation;

      emit(PokedexStateFetchPokemon(pokemonModelList: [], canLoad: true, generation: _generation));
      add(PokedexEventLoad());
    }
  }
}
