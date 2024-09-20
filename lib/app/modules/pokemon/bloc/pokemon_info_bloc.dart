import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/app/core/exceptions/message_exception.dart';
import 'package:pokedex_app/app/models/pokemon_info_model.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

part 'pokemon_info_event.dart';
part 'pokemon_info_state.dart';

class PokemonInfoBloc extends Bloc<PokemonInfoEvent, PokemonInfoState> {
  final PokemonRepository _pokemonRepository;

  PokemonInfoBloc({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository,
        super(PokemonInfoInit()) {
    on<PokemonInfoLoad>(_load);
  }

  Future<void> _load(PokemonInfoLoad event, Emitter<PokemonInfoState> emit) async {
    try {
      emit(PokemonInfoLoading());
      final PokemonInfoModel pokemonInfo = await _pokemonRepository.getPokemonInfoById(id: event.id);
      emit(PokemonInfoFetch(data: pokemonInfo));
    } on MessageException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      emit(PokemonInfoError(message: 'Erro ao carregar informações'));
    }
  }
}
