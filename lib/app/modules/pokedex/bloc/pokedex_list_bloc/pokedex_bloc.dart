import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_generation_enum.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_genration_limits.dart';
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

      //* O state init só carrega os pokemons da primeira geração, então não é necessário
      //* encontrar um range nesse fetch
      if (currentState is PokedexStateInit) {
        emit(PokedexStateLoading(pokemonModelListHolder: [], isLoading: true));

        final list = await _fetchData(limit: 8, offset: 0);

        emit(PokedexStateFetchPokemon(pokemonModelList: list, isLoading: true));
      }

      if (currentState is PokedexStateFetchPokemon) {
        const gen = PokemonGenerationEnum.gen1;
        final bounds = PokemonGenrationLimits().getGenerationRange(gen);

        bool isLoading = true;
        int toLoad = 4; //* Número de pokemons que serão carregados por scroll
        final int genLimit = bounds['limit'] ?? 1;
        final int offset = currentState.pokemonModelList.length;

        //* Limitando o limite de carregament para não ultrapassar o limite da geração (de pokemon)
        int limit = offset + toLoad;
        if (limit > genLimit) {
          limit = genLimit;
          isLoading = false;
        }

        emit(PokedexStateLoading(
            pokemonModelListHolder: currentState.pokemonModelList, isLoading: isLoading));

        final list = await _fetchData(limit: limit, offset: offset);

        if (list.isNotEmpty) {
          emit(PokedexStateFetchPokemon(
              pokemonModelList: currentState.pokemonModelList + list, isLoading: isLoading));
        }
      }
    } on Exception catch (e, s) {
      log('Erro ao carregar feed: ', error: e, stackTrace: s);
      emit(PokedexStateError(error: 'Erro ao carregar fedd'));
    }
  }

  Future<List<PokemonModel>> _fetchData({required int offset, required int limit}) async {
    List<PokemonModel> pokemonModelList = [];

    //* Sim, eu sei, um for que faz um request por iteration é estúpido,
    //* mas a culpa é da API, ou eu sou ignorante
    for (int i = offset; i < limit; i++) {
      final pokemonModel = await _pokemonRepository.getPokemonById(id: i + 1);
      pokemonModelList.add(pokemonModel);
    }

    return pokemonModelList;
  }
}
