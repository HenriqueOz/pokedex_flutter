part of 'pokemon_view_cubit.dart';

abstract class PokemonViewState {
  final bool shiny;
  final int tab;

  PokemonViewState({required this.shiny, required this.tab});
}

class PokemonViewData extends PokemonViewState {
  PokemonViewData({required super.shiny, required super.tab});
}
