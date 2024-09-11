part of 'pokedex_bloc.dart';

abstract class PokedexEvent {}

class PokedexEventLoad extends PokedexEvent {
  final int quantity;
  PokedexEventLoad({required this.quantity});
}
