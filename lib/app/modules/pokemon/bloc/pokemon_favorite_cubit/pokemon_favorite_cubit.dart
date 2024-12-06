import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

part 'pokemon_favorite_state.dart';

class PokemonFavoriteCubit extends Cubit<PokemonFavoriteState> {
  final PokemonRepository _pokemonRepository;

  PokemonFavoriteCubit({required PokemonRepository pokemonRepositoy})
      : _pokemonRepository = pokemonRepositoy,
        super(PokemonFavoriteFetch(isFavorite: false));

  void addFavorite({required int id}) async {
    try {
      await _pokemonRepository.addFavoriteById(id: id);
      emit(PokemonFavoriteFetch(isFavorite: true));
    } catch (e) {
      emit(PokemonFavoriteFetch(isFavorite: false));
    }
  }

  void removeFavorite({required int id}) async {
    try {
      await _pokemonRepository.removeFavoriteById(id: id);
      emit(PokemonFavoriteFetch(isFavorite: false));
    } catch (e) {
      emit(PokemonFavoriteFetch(isFavorite: false));
    }
  }

  void getFavorite({required int id}) async {
    try {
      final bool isFavorite = await _pokemonRepository.getFavoriteById(id: id);
      emit(PokemonFavoriteFetch(isFavorite: isFavorite));
    } catch (e) {
      emit(PokemonFavoriteFetch(isFavorite: false));
    }
  }
}
