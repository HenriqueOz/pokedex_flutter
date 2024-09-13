part of 'pokedex_scroll_bloc.dart';

class PokedexScrollState {}

class PokedexScrollInitial extends PokedexScrollState {}

class PokedexScrollData extends PokedexScrollState {
  final bool isActive;
  PokedexScrollData({required this.isActive});
}
