import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/app/models/pokemon_info_model.dart';
import 'package:pokedex_app/app/models/pokemon_model.dart';
import 'package:pokedex_app/app/models/pokemon_name_list_model.dart';
import 'package:pokedex_app/app/repositories/pokemon_repository.dart';

void main() {
  group(
    PokemonRepository,
    () {
      test(
        'get a reponse from api and return a pokemon model',
        () async {
          // getting bulbassaur model instance
          final PokemonModel model = await PokemonRepository().getPokemonById(id: 1);
          debugPrint(model.toString());

          expect(model, isInstanceOf<PokemonModel>());
        },
      );
      test(
        'get a reponse from the api and return a pokemon info model',
        () async {
          final model = await PokemonRepository().getPokemonInfoById(id: 1);

          debugPrint(model.toString());

          expect(model, isInstanceOf<PokemonInfoModel>());
        },
      );
      test(
        'get a response from the api and return a pokemon name list model',
        () async {
          final model = await PokemonRepository().getPokemonNameListModel();

          debugPrint(model.toString());

          expect(model, isInstanceOf<PokemonNameListModel>());
        },
      );
    },
  );
}
