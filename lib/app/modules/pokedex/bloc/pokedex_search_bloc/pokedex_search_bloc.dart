import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/repositories/pokemon_name_list_repository.dart';

part 'pokedex_search_event.dart';
part 'pokedex_search_state.dart';

class PokedexSearchBloc extends Bloc<PokedexSearchEvent, PokedexSearchState> {
  final PokemonNameListRepository _pokemonNameListRepository;

  PokedexSearchBloc({required PokemonNameListRepository pokemonNameListRepository})
      : _pokemonNameListRepository = pokemonNameListRepository,
        super(PokedexSearchFetch(list: [])) {
    on<PokedexSearchFindName>(_findName);
  }

  Future<void> _findName(PokedexSearchFindName event, Emitter<PokedexSearchState> emit) async {
    try {
      final List<String> list = await _pokemonNameListRepository.searchInNameList(event.name);
      emit(PokedexSearchFetch(list: list));
    } on MessageException catch (e) {
      emit(PokedexSearchFetch(list: [e.message]));
    }
  }
}
