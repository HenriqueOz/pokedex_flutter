part of 'favorites_bloc.dart';

abstract class FavoritesStates {}

class FavoritesInit extends FavoritesStates {}

class FavoritesFetch extends FavoritesStates {
  final List<PokemonModel> list;
  FavoritesFetch({required this.list});
}

class FavoritesLoading extends FavoritesStates {
  final List<PokemonModel> list;
  FavoritesLoading({required this.list});
}

class FavoritesError extends FavoritesStates {
  final String message;
  final List<PokemonModel> list;
  FavoritesError({required this.message, required this.list});
}
