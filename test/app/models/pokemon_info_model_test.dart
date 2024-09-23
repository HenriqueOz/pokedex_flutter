import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/app/models/pokemon_info_model.dart';

void main() {
  group(
    PokemonInfoModel,
    () {
      test(
        'Return a pokemon info model from a given map of string dynamic',
        () async {
          final dio = Dio();
          const int id = 850;
          final responseStats = dio.get('https://pokeapi.co/api/v2/pokemon/$id');
          final responseDescription = dio.get('https://pokeapi.co/api/v2/pokemon-species/$id');

          final responses = await Future.wait([responseStats, responseDescription]);

          final Map<String, dynamic> map = {};
          for (var response in responses) {
            map.addAll(response.data);
          }

          final PokemonInfoModel model = PokemonInfoModel.fromMap(map);

          debugPrint(model.toString());

          expect(model, isInstanceOf<PokemonInfoModel>());
        },
      );
    },
  );
}
