part of 'pokedex_bloc.dart';

abstract class PokedexEvent {}

class PokedexEventLoad extends PokedexEvent {}

class PokedexEventChangeGen extends PokedexEvent {
  final PokemonGenerationEnum generation;
  PokedexEventChangeGen({required this.generation});
}
