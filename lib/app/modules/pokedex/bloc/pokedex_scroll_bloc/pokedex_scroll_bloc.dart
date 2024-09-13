import 'dart:async';

import 'package:bloc/bloc.dart';

part 'pokedex_scroll_event.dart';
part 'pokedex_scroll_state.dart';

class PokedexScrollBloc extends Bloc<PokedexScrollEvent, PokedexScrollState> {
  PokedexScrollBloc() : super(PokedexScrollInitial()) {
    on<PokedexScrollEventEnable>(_enable);
    on<PokedexScrollEventDisable>(_disable);
  }

  Future<void> _enable(PokedexScrollEventEnable event, Emitter<PokedexScrollState> emit) async {
    emit(PokedexScrollData(isActive: true));
  }

  Future<void> _disable(PokedexScrollEventDisable event, Emitter<PokedexScrollState> emit) async {
    emit(PokedexScrollData(isActive: false));
  }
}
