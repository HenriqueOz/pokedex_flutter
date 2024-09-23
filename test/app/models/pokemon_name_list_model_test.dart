import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/app/core/pokemon_data/pokemon_count.dart';
import 'package:pokedex_app/app/models/pokemon_name_list_model.dart';

void main() {
  group(
    PokemonNameListModel,
    () {
      test(
        'build an instance of pokemonNameListModel from a map of string, dynamic given by the poke api',
        () async {
          final dio = Dio();
          final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=${PokemonCount.count}&offset=0');

          final model = PokemonNameListModel.fromMap(response.data);

          debugPrint(model.toString());

          expect(model, isInstanceOf<PokemonNameListModel>());
        },
      );
    },
  );
}
