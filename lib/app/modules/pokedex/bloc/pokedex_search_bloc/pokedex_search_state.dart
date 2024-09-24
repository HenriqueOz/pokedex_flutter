part of 'pokedex_search_bloc.dart';

class PokedexSearchState {
  final List<String> list;
  PokedexSearchState({
    required this.list,
  });

  PokedexSearchState copyWith({
    List<String>? list,
  }) {
    return PokedexSearchState(
      list: list ?? this.list,
    );
  }
}

final class PokedexSearchFetch extends PokedexSearchState {
  PokedexSearchFetch({required super.list});
}
