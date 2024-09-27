import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/repositories/pokemon_name_list_repository.dart';

part 'splash_events.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvents, SplashState> {
  final PokemonNameListRepository _pokemonNameListRepository;

  SplashBloc({required PokemonNameListRepository pokemonNameListRepository})
      : _pokemonNameListRepository = pokemonNameListRepository,
        super(SplashLoading()) {
    on<SplashLoad>(_load);
  }

  Future<void> _load(SplashLoad event, Emitter<SplashState> emit) async {
    try {
      emit(SplashLoading());
      await _pokemonNameListRepository.loadNameList();
      emit(SplashSuccess());
    } on MessageException catch (e) {
      emit(SplashError(message: e.message));
    }
  }
}
