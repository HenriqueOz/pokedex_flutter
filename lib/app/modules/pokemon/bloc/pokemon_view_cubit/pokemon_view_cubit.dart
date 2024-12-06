import 'package:flutter_bloc/flutter_bloc.dart';

part 'pokemon_view_state.dart';

class PokemonViewCubit extends Cubit<PokemonViewState> {
  int _currentTab = 0;
  bool _isShiny = false;

  PokemonViewCubit() : super(PokemonViewData(shiny: false, tab: 0));

  void showShiny() {
    _isShiny = true;
    emit(PokemonViewData(shiny: _isShiny, tab: _currentTab));
  }

  void showNorma() {
    _isShiny = false;
    emit(PokemonViewData(shiny: _isShiny, tab: _currentTab));
  }

  void changeTab({required int tab, required int length}) {
    if (tab < length) {
      _currentTab = tab;
      emit(PokemonViewData(shiny: _isShiny, tab: _currentTab));
    }
  }
}
