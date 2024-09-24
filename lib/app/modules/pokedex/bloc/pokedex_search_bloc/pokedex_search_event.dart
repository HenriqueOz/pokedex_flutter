part of 'pokedex_search_bloc.dart';

abstract class PokedexSearchEvent {}

final class PokedexSearchFindName extends PokedexSearchEvent {
  final String name;
  PokedexSearchFindName({required this.name});
}
