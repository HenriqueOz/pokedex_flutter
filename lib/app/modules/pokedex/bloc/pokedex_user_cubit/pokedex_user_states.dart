part of 'pokedex_user_cubit.dart';

abstract class PokedexUserStates {}

class PokedexUserInit extends PokedexUserStates {}

class PokedexUserFetch extends PokedexUserStates {
  final UserModel userModel;
  PokedexUserFetch({required this.userModel});
}

class PokedexUserError extends PokedexUserStates {
  final String message;
  PokedexUserError({required this.message});
}
