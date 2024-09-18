import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_genration_limits.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final PokemonRepository _pokemonRepository;
  PokemonGenerationEnum _generation = PokemonGenerationEnum.gen1;

  PokedexBloc({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository,
        super(PokedexStateInit()) {
    on<PokedexEventLoad>(_load);
    on<PokedexEventChangeGen>(_changeGen, transformer: restartable());
  }

  Future<void> _load(PokedexEventLoad event, Emitter<PokedexState> emit) async {
    //* Setando a geração que será feito o fetch
    PokemonGenrationLimits.setGenerationRange(_generation);

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
        bool canLoad = true;
        int toLoad = 10; //* Número de pokemons que serão carregados por scroll
        final int listLength = currentState.pokemonModelList.length;

        final int genLimit = PokemonGenrationLimits.limit;
        final int offset = PokemonGenrationLimits.offset + listLength;

        //* Limitando o toLoad para não ultrapassar o limite da geração
        if ((listLength + toLoad) > genLimit) {
          toLoad = genLimit - listLength;
        }

        if (toLoad == 0) {
          canLoad = false;
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

  /// carrega uma lista de pokemon model a partir de um ponto de partida offset
  /// (id da pokedex de partida) e limitando-se a quantidade quantity
  /// (quantos itens serão carregador a partir do offset)
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
