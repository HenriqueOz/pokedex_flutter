import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:path/path.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_genration_limits.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final PokemonRepository _pokemonRepository;
  PokemonGenerationEnum _generation = PokemonGenerationEnum.gen1;
  bool _genChanged = false;

  PokedexBloc({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository,
        super(PokedexStateInit()) {
    on<PokedexEventLoad>(_load);
    on<PokedexEventChangeGen>(_changeGen);
  }

  Future<void> _load(PokedexEventLoad event, Emitter<PokedexState> emit) async {
    try {
      //* Setando a geração que será feito o fetch
      final generation = _generation;
      PokemonGenrationLimits.setGenerationRange(generation);

      final currentState = state;

      if (currentState is PokedexStateInit) {
        emit(PokedexStateLoading(pokemonModelListHolder: [], isLoading: true, generation: generation));

        final list = await _fetchData(quantity: 10, offset: PokemonGenrationLimits.offset);

        emit(PokedexStateFetchPokemon(pokemonModelList: list, isLoading: true, generation: generation));
      }

      if (currentState is PokedexStateFetchPokemon) {
        bool isLoading = true;
        int toLoad = 10; //* Número de pokemons que serão carregados por scroll
        final int listLength = currentState.pokemonModelList.length;

        final int genLimit = PokemonGenrationLimits.limit;
        final int offset = PokemonGenrationLimits.offset + listLength;

        //* Limitando o toLoad para não ultrapassar o limite da geração
        if ((listLength + toLoad) > genLimit) {
          toLoad = genLimit - listLength;
        }

        if (toLoad == 0) {
          isLoading = false;
        }

        final oldList = currentState.pokemonModelList;

        //! Arrumar isso aqui
        if (_genChanged) {
          oldList.clear();
          emit(PokedexStateLoading(pokemonModelListHolder: [], isLoading: isLoading, generation: generation));
          emit(PokedexStateFetchPokemon(pokemonModelList: [], isLoading: isLoading, generation: generation));
          _genChanged = false;
        } else {
          emit(PokedexStateLoading(pokemonModelListHolder: oldList, isLoading: isLoading, generation: generation));
          final list = await _fetchData(quantity: toLoad, offset: offset);
          emit(PokedexStateFetchPokemon(pokemonModelList: oldList + list, isLoading: isLoading, generation: generation));
        }
      }
    } on Exception catch (e, s) {
      log('Erro ao carregar feed: ', error: e, stackTrace: s);
      emit(PokedexStateError(error: 'Erro ao carregar feed'));
    }
  }

  /// carrega uma lista de pokemon model a partir de um ponto de partida offset
  /// (id da pokedex de partida) e limitando-se a quantidade quantity
  /// (quantos itens serão carregador a partir do offset)
  Future<List<PokemonModel>> _fetchData({required int offset, required int quantity}) async {
    final List<Future<PokemonModel>> toFetchList = [];

    //* Sim, eu sei, um for que faz um request por iteration é estúpido,
    //* mas a culpa é da API, ou eu sou ignorante
    quantity = quantity + offset;
    for (int i = offset; i < quantity; i++) {
      toFetchList.add(_pokemonRepository.getPokemonById(id: i + 1));
    }

    final fetchedList = Future.wait(toFetchList);

    return fetchedList;
  }

  Future<void> _changeGen(PokedexEventChangeGen event, Emitter<PokedexState> emit) async {
    if (_generation != event.generation) {
      _genChanged = true;
      _generation = event.generation;
    }
  }
}
