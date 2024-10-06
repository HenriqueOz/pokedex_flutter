import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
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
    },
  );
}
