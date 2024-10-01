part of 'pokemon_favorite_cubit.dart';

abstract class PokemonFavoriteState {}

class PokemonFavoriteFetch extends PokemonFavoriteState {
  final bool isFavorite;
  PokemonFavoriteFetch({required this.isFavorite});
}
