part of 'pokemon_info_bloc.dart';

@immutable
sealed class PokemonInfoState {}

final class PokemonInfoInit extends PokemonInfoState {}

final class PokemonInfoLoading extends PokemonInfoState {}

final class PokemonInfoFetch extends PokemonInfoState {
  final PokemonInfoModel data;
  PokemonInfoFetch({required this.data});
}

final class PokemonInfoError extends PokemonInfoState {
  final String message;
  PokemonInfoError({required this.message});
}
