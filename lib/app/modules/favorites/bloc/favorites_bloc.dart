import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

part 'favorites_events.dart';
part 'favorites_states.dart';

class FavoritesBloc extends Bloc<FavoritesEvents, FavoritesStates> {
  final PokemonRepository _pokemonRepository;
  int _favoritesLength = 0;
  List<int> _favoritesList = [];

  FavoritesBloc({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository,
        super(FavoritesInit()) {
    on<FavoritesLoad>(_load);
    on<FavoritesRefresh>(_refresh);
  }

  Future<void> _load(FavoritesLoad event, Emitter<FavoritesStates> emit) async {
    final currentState = state;

    if (currentState is FavoritesInit) {
      _favoritesList = await _pokemonRepository.getFavoriteList();
      _favoritesLength = _favoritesList.length;
      emit(FavoritesFetch(list: []));
      add(FavoritesLoad());
    }

    if (currentState is FavoritesFetch) {
      try {
        _favoritesList = await _pokemonRepository.getFavoriteList();
        _favoritesLength = _favoritesList.length;

        final modelListLength = currentState.list.length;

        if (modelListLength < _favoritesList.length) {
          emit(FavoritesLoading(list: currentState.list));

          final List<PokemonModel> list = [];
          for (int i = modelListLength; i < _favoritesLength && i < (modelListLength + 10); i++) {
            // debugPrint(list.toString());
            final model = await _pokemonRepository.getPokemonById(id: _favoritesList[i]);
            list.add(model);
          }
          emit(FavoritesFetch(list: currentState.list + list));
        }
      } on MessageException catch (e) {
        emit(FavoritesError(message: e.message, list: currentState.list));
      }
    }

    if (currentState is FavoritesError) {
      emit(FavoritesFetch(list: currentState.list));
      add(FavoritesLoad());
    }
  }

  Future<void> _refresh(FavoritesRefresh event, Emitter<FavoritesStates> emit) async {
    if (state is FavoritesFetch) {
      emit(FavoritesFetch(list: []));
      add(FavoritesLoad());
    }
  }
}
