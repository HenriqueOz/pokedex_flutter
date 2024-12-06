part of 'pokemon_info_bloc.dart';

@immutable
sealed class PokemonInfoEvent {}

final class PokemonInfoLoad extends PokemonInfoEvent {
  final int id;
  PokemonInfoLoad({required this.id});
}
