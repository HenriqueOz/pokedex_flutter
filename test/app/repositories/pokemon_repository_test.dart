import 'package:dio/dio.dart';
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
        'return a list which contains all the alternative versions/forms of pokemons',
        () async {
          final dio = Dio();
          final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=10000&offset=1025');

          List<dynamic> list = response.data['results'];

          list = list.map((e) => e['name']).toList();

          for (int i = 0; i < list.length; i++) {
            debugPrint('$i: ${list[i]}');
          }
        },
      );
      test(
        'get a reponse from api and return a pokemon model',
        () async {
          // getting bulbassaur model instance
          int id = 10143;
          final PokemonModel model = await PokemonRepository().getPokemonById(id: id);
          debugPrint(model.toString());

          expect(model, isInstanceOf<PokemonModel>());
        },
      );
      test(
        'get a reponse from the api and return a pokemon info model',
        () async {
          final model = await PokemonRepository().getPokemonInfoById(id: 386);

          debugPrint(model.toString());

          expect(model, isInstanceOf<PokemonInfoModel>());
        },
      );
      test(
        'get a response from the api and return a pokemon name list model',
        () async {
          final model = await PokemonRepository().getPokemonNameListModel(0, 100);

          debugPrint(model.toString());

          expect(model, isInstanceOf<PokemonNameListModel>());
        },
      );
    },
  );
}
