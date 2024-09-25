part of 'pokedex_search_bloc.dart';

abstract class PokedexSearchState {}

class PokedexSearchFetch extends PokedexSearchState {
  final List<String> list;
  PokedexSearchFetch({required this.list});
}
